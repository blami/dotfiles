import re

from ansible.errors import AnsibleFilterError

def xwinuninstr(uninstr):
    """_Attempts_ to fix Windows registry UninstallStrings that are not
    properly doublequoted."""
    if uninstr == "\"":
        return uninstr # already doublequoted

    # Attempt to find executable extension
    path_end = re.search("(?s:.*)\.(exe|msi)", uninstr)
    # if not successful attempt to find first / (argument)
    if path_end is None:
        path_end = re.search("/[^ ]+", uninstr)

    if path_end is None:
        raise AnsibleFilterError(f"ambigous UninstallString: {uninstr}")

    i = path_end.end()
    return f"\"{uninstr[:i]}\"{uninstr[i:]}"


class FilterModule(object):
    def filters(self):
        return {"xwinuninstr": xwinuninstr}
