import re

from ansible.errors import AnsibleFilterError

def xwin_path(arg, **kw):
    """Convert Unix path to Windows.

    If path starts with / convert that to C:\, then flip all /'s to \\'s.
    """
    drive = kw.get('drive', None)
    if drive:
        if len(drive) != 1:
            raise AnsibleFilterError(f"invalid drive {drive}")
        arg = re.sub(r'^\/', re.escape(drive.upper()) + r':\\', arg)
    arg = arg.replace('/', '\\')
    return arg


class FilterModule(object):
    def filters(self):
        return {
            "xwin_path": xwin_path
        }
