from collections.abc import Mapping

from ansible.template import AnsibleUndefined
from ansible.errors import AnsibleFilterError


def xcombine(*args, **kw):
    """Combine all given dictionaries to one, if there are overlapping keys
    overwrite them by later values. Ignore undefined or None dictionaries.

    If keyword argument remove_none=True is passed then all None value keys
    will be removed from result.
    """
    result = {}
    for arg in args:
        if isinstance(arg, AnsibleUndefined) or arg is None:
            # Skip undefined or None
            pass
        elif isinstance(arg, Mapping):
            result.update(arg)
        else:
            raise AnsibleFilterError("Argument is not a dictionary")

    if kw.get("remove_none", False):
        result = {k: v for k, v in result.items() if v is not None}

    return result

class FilterModule(object):
    def filters(self):
        return {"xcombine": xcombine}
