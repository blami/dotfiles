from collections.abc import Mapping

class FilterModule(object):
    def filters(self):
        return {
            "xany": any,
            "xall": all,
            }

