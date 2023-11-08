import base64
import json
import os
import sys
from subprocess import PIPE, STDOUT, Popen, TimeoutExpired

from ansible.errors import AnsibleError
from ansible.plugins.lookup import LookupBase

# from ansible.utils import display

DOCUMENTATION = """
name: bitwarden
author: Ondrej Balaz <blami@blami.net>
short_description: look up fields and attachments from Bitwarden
description: 
  - Access Bitwarden Vault through logged-in and unlocked CLI; look up and
    return fields or attachments by item name or id.
options:
  _terms:
    description: item name or id. If no names are provided lookup will
      return True if Bitwarden Vault is ready to use, otherwise False.
  field:
    description: field to lookup and return value of. Nested fields can be
      accessed using '.' notation. Standard fields are under 'login.*', custom
      fields are under 'fields.*'. Mutually exclusive with 'attachment'.
    default: 'login.password'
  attachment:
    description: name of attachment to fetch. Attachment will be base64 encoded
      in ASCII. For binary files use '{{ lookup(..) | b64decode }}'. Mutually
      exclusive with 'field'.
  path:
    description: path to Bitwarden CLI binary.
    default: bw
  session:
    description: Bitwarden session id
    default: '$BW_SESSION'
"""

EXAMPLES = """
- name: Check Bitwarden Status
  debug:
    msg: "{{ lookup('bitwarden') }}

- name: Retrieve Password for Google
  debug:
    msg: "{{ lookup('bitwarden', 'Google') }}"

- name: Retrieve test.txt attachment of Test
  debug:
    msg: "{{ lookup('bitwarden', 'Test', attachment='test.txt') | b64decode }}
"""


class Bitwarden:
    def __init__(self, path="bw", session=None, timeout=5):
        self._path = path
        self._session = session
        self._timeout = timeout
        self._status = False

    def _run(self, args: str, raw=False) -> dict:
        """Run Bitwarden command line tool."""
        env = os.environ.copy()
        if self._session is not None:
            env["BW_SESSION"] = self._session

        try:
            # Make Bitwarden CLI never prompt any input
            p = Popen(
                [self._path, "--nointeraction"] + args,
                stdin=PIPE,
                stdout=PIPE,
                stderr=STDOUT,
                env=env,
            )
            out, _ = p.communicate(timeout=self._timeout)
            if not raw:
                out = out.decode()
                out = out.strip()
            rc = p.wait()
        except TimeoutExpired as err:
            p.kill()
            raise RuntimeError(f"{self._path} timed out after {self._timeout}s")
        except Exception as err:
            raise RuntimeError(err) from err
        if rc != 0:
            raise RuntimeError(f"{self._path} exited with rc={rc}: {out}")
        return out

    def _get_item(self, query):
        """Get item by name or id."""
        try:
            # Use list instead of get and attempt do de-ambiguify items
            items = json.loads(self._run(["list", "items", "--search", query]))
            items = [
                i
                for i in items
                if i.get("object") == "item" and query in (i.get("name"), i.get("id"))
            ]
        except (RuntimeError, json.JSONDecodeError) as err:
            raise AnsibleError(err) from err

        if not items:
            raise AnsibleError(f"item matching '{query}' not found")
        if len(items) > 1:
            raise AnsibleError(f"'{query}' is ambiguous, use item id")
        return items[0]

    def status(self):
        """Returns True if Bitwarden vault is unlocked and ready to use,
        otherwise False."""
        try:
            out = json.loads(self._run(["status"]))
        except:
            return False

        unlocked = out.get("status") == "unlocked"

        # BUG: There's a bug in bitwarden that reports vault is locked even if
        # it is not. This is to temporarily workaround it.
        if not unlocked:
            try:
                self._run(["list", "folders"])
                unlocked = True
            except:
                unlocked = False

        return unlocked

    def get_field(self, query, field):
        """Get value of any given field in item object. Nested fields can be
        accessed via '.' notation (e.g. 'login.password')."""
        item = self._get_item(query)
        try:
            # Convert custom fields to fields.name = value
            if "fields" in item:
                item["fields"] = {f["name"]: f["value"] for f in item["fields"]}

            keys = field.split(".")
            value = item
            for key in keys:
                value = value[key]
            return value
        except KeyError as err:
            raise AnsibleError(f"invalid field '{field}'") from err

    def get_attachment(self, query, attachment):
        """Get attachment as base64 encoded ASCII data."""
        item = self._get_item(query)
        try:
            attachment = self._run(
                ["get", "attachment", attachment, "--itemid", item["id"], "--raw"],
                raw=True,
            )
        except RuntimeError as err:
            raise AnsibleError(f"invalid attachment '{attachment}': {err}")
        return base64.b64encode(attachment).decode("ascii")


class LookupModule(LookupBase):
    def run(self, terms, variables=None, **kwargs):

        bw = Bitwarden(
            path=kwargs.get("path", "bw"),
            session=kwargs.get("session", os.environ.get("BW_SESSION", None)),
        )

        # Return status if no terms are given
        if len(terms) == 0:
            return [bw.status()]

        if sum([k in kwargs.keys() for k in ["attachment", "field"]]) > 1:
            raise AnsibleError("'field' and 'attachment' are mutually exclusive")

        attachment = kwargs.get("attachment")
        # Field is default
        field = kwargs.get("field", "login.password")

        values = []
        for term in terms:
            if attachment:
                values.append(bw.get_attachment(term, attachment))
            else:
                values.append(bw.get_field(term, field))

        return values
