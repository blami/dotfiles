from collections.abc import Mapping

from ansible.template import AnsibleUndefined
from ansible.errors import AnsibleFilterError


def xcombine(*args, **kw):
    """Combine all given dictionaries to one, if there are overlapping keys
    overwrite them by later values. Ignore undefined or None dictionaries."""
    result = {}
    for arg in args:
        if isinstance(arg, AnsibleUndefined) or arg is None:
            # Skip undefined or None
            pass
        elif isinstance(arg, Mapping):
            result.update(arg)
        else:
            raise AnsibleFilterError("Argument is not a dictionary")
    return result


class FilterModule(object):
    def filters(self):
        return {"xcombine": xcombine}
