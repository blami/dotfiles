def xis_list(obj):
    return isinstance(obj, list)

def xis_dict(obj):
    return isinstance(obj, dict)

class FilterModule(object):
    def filters(self):
        return {
            "xis_list": xis_list,
            "xis_dict": xis_dict,
            }

