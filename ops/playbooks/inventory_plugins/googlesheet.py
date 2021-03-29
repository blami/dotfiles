"""
Google Sheet Inventory Plugin
=============================
This dynamic inventory plugin for Ansible loads hosts, their IP addresses and
roles they should have from Google Sheet.

Dependencies
------------
This plugin requires following libraries for same Python version as Ansible
uses (currently 2.7).
- ``google-auth``
- ``requests``

Spreadsheet Formatting
----------------------
Expected format is table where first row is header used to identify interesting
columns.

Google Setup
------------
In order to make Google Sheet accessible to this plugin following steps are
necessary:

- Go to [Google APIs Console](https://console.developers.google.com/)
- Create a new project
- In "APIs" card go to "APIs overview" (or "Explore and enable APIs")
- Click blue "Enable APIs and Services" button and select **Google Sheets API**
- Click "Create Credentials" button, select **Google Sheets API** and create
  credentials for "Web server" to access "Application Data" and select you are
  not using GCE nor GAE.
- Click "Check ..." button and fill-in "Create a service account" form. Name
  account as you like (default is ``AnsibleInventory``) and give it role of
  *Project -> Viewer*. Select "Key type" *JSON* and click "Continue".
- Download JSON file and store it **SECURELY**.
- Go to [Google Drive](https://drive.google.com)
- Find a spreadsheet with your hosts (or create one)
- Click "Share" button and share with client e-mail from downloaded JSON.
"""
import string

from ansible.plugins.inventory import BaseInventoryPlugin, \
                                      Constructable, \
                                      Cacheable
from google.oauth2.service_account import Credentials
from google.auth.transport.requests import AuthorizedSession

# Google Spreadsheet API endpoint URL
URL='https://sheets.googleapis.com/v4/spreadsheets'

# TODO Make this configurable
KEYFILE='/mnt/c/Users/blami/downl/ansibleinventory-7c7274e39644.json'
# Taken from URL
SPREADSHEET_ID='1iiJ3YeW4F1HSl0mdYnaineTX7KLn0RCJt_9CeVw_r0c'
IP_COL='IP'
HOSTNAME_COL='Hostname'
ROLES_COL='Roles'


DOCUMENTATION='aaaa'
EXAMPLES='bbb'

__metaclass__ = type


class GoogleSheetInventoryPlugin(BaseInventoryPlugin):
    """Lalalala"""
    NAME = 'googlesheet'

    @staticmethod
    def get_session(keyfile):
        """Obtain requests authorized HTTP session.

        :param keyfile: Path to JSON key file generated using Google API console.
        :return: Requests HTTP session object.
        """
        # Read-only access is enough, no general Drive access is required
        scopes = ['https://www.googleapis.com/auth/spreadsheets.readonly']
        creds = Credentials.from_service_account_file(keyfile, scopes=scopes)
        return AuthorizedSession(creds)


    @staticmethod
    def get_hosts(session, spreadsheet_id, gid=0, header=True, ip='IP',
                hostname='Hostname', roles='Roles'):
        """Get list of  ``(hostname, ip, [roles])`` from spreadsheed of given
        ``spreadsheet_id``.

        If ``header`` argument is set then first row will be ignored and considered
        header, if ``ip``, ``hostname`` and ``roles`` are strings then will be
        matched against header row to determine indices of these columns. If
        ``header`` is not set, these must be integers.
        """
        if not header and \
                not all([isinstance(o, int) for o in (ip, hostname, roles)]):
            raise ValueError("Without header column indices must be integers")

        def _a1range(col, row):
            """Return A1 range for given position in sheet.

            :param col: Numeric column.
            :param row: Numeric row.
            :return: A1 style range.
            """
            out = ''
            # Column to letter
            quot = col
            while quot > 0:
                quot, rem = divmod(quot - 1, 26)
                out = '{}{}'.format(string.ascii_uppercase[rem], out)
            return '{}{}'.format(out, row)

        def _get(endpoint, params={}):
            """Make GET request and return JSON dictionary.

            :param endpoint: Endpoint to make request to.
            :param params: Dictionary of URL parameters.
            :return: JSON dictionary.
            """
            resp = session.get('{}/{}'.format(URL, endpoint))
            code = resp.status_code
            if code not in (200,):
                raise RuntimeError('Invalid REST API response ({})'.format(code))
            # All responses from Sheets API are JSON
            return resp.json()

        # Get range of sheet first
        dims = None
        data = _get(SPREADSHEET_ID)
        for s in data.get('sheets', []):
            if s['properties']['index'] == gid:
                cols = s['properties']['gridProperties']['columnCount']
                rows = s['properties']['gridProperties']['rowCount']
                dims = (cols, rows)
        if not dims:
            raise RuntimeError('Unable to get dimensions of sheet {}'.format(gid))

        # Get cell data
        range_='A1%3A{}'.format(_a1range(dims[0], dims[1]))
        data = _get('{}/values/{}'.format(SPREADSHEET_ID, range_))

        data = data['values']
        if header:
            # Split header from data
            header = data[0]
            data = data[1:]

            # Find column indices
            def _find_index(value):
                """Find index for given value (if it's not already index)."""
                if isinstance(value, int):
                    return value
                try:
                    return header.index(value)
                except ValueError:
                    raise ValueError("Column {} not found".format(var))

            ip = _find_index(ip)
            hostname = _find_index(hostname)
            roles = _find_index(roles)

        if any(i >= dims[0] for i in (ip, hostname, roles)):
            raise ValueError("One or more invalid column indices")

        # Get rows where both IP and hostname are set
        out = []
        for row in data:
            if row[ip] and row[hostname] and len(row) > max(ip, hostname):
                value_roles = []
                if len(row) > roles:
                    value_roles = str(row[roles]).split(',')
                out.append((row[hostname], row[ip], value_roles))

        return(out)

    def verify_file(self, path):
        """Check whether file can be consumed."""
        return True

    def parse(self, inventory, loader, path, cache=True):
        """Parse Google Spreadsheet and populate inventory."""
        super(InventoryModule, self).parse(inventory, loader, path, cache)
        config = self._read_config_data(self, path)

        #self.get_option('drive_key')
        #self.get_option('drive_...')

        hosts = self.get_hosts(self.get_session(KEYFILE), SPREADSHEET_ID)
        for host in hosts:
            self.inventory.add_host(host[0])
            self.inventory.set_variable('ansible_host', host[1])
