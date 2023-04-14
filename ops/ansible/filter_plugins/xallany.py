class FilterModule(object):
    def filters(self):
        return {
            "xany": any,
            "xall": all,
            }
