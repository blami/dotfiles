from __future__ import (absolute_import, division, print_function)
from pathlib import Path
import shutil

from ansible.module_utils.basic import AnsibleModule

__metaclass__ = type

DOCUMENTATION = r'''
---
module: xdir

short_description: Create or remove directory or link to directory on Unix. 
'''

# NOTE: See also xwin_dir.ps1

def main():
    module = AnsibleModule(
        argument_spec = dict(
            path=dict(type='path', required=True),
            state=dict(type='str', choices=['directory', 'link', 'absent', 'skip'], default='directory'),
            link=dict(type='path'),
            #umask=dict(type='str')
            #mode=dict(type='str', required=False),
            #owner=dict(type='str', required=False),
            #group=dict(type='str', required=False),
            force=dict(type='bool', default=False),
            # Linux only options

        ),
        supports_check_mode=False
    )

    result = dict(
        changed=False,
        original_message='',
        message=''
    )

    p = Path(module.params['path'])
    state = module.params['state']
    exists = p.exists(follow_symlinks=False)

    # Validations
    if exists and not p.is_dir() and not p.is_symlink():
        module.fail_json(msg=f"path {p} exists but is neither directory nor link", **result)
    if exists and state == 'directory' and not p.is_dir():
        module.fail_json(msg=f"path {p} exists but is not directory", **result)
    if exists and state == 'link' and not p.is_symlink():
        module.fail_json(msg=f"path {p} exists but is not link", **result)
    if state == 'link' and ('link' not in module.params or module.params['link'] is None):
        module.fail_json(msg=f"link property cannot be empty", **result)

    if state == 'skip':
        # Do nothing, just skip the directory
        pass
    elif state == 'absent':
        if exists:
            if p.is_symlink():
                p.unlink()
            else:
                # NOTE: Debian Python3 pathlib does not have p.rmtree() yet...
                shutil.rmtree(p)

            result['changed'] = True
    else:
        # TODO: os.umask(0o...)
        if not exists:
            # NOTE: Do not create directory/link if its parent directory does
            # not exist without force: True
            if not module.params['force'] and not p.parent.exists():
                module.fail_json(msg=f"unable to create {p}; parent directory does not exist", **result)

            if state == 'directory':
                p.mkdir(parents=True, exist_ok=True)
            if state == 'link':
                p.symlink_to(target=module.params['link'])

            result['changed'] = True
        else:
            # Fix wrong link
            if exists and p.is_symlink() and p.readlink() != Path(module.params['link']):
                p.unlink()
                p.symlink_to(target=module.params['link'])
                result['changed'] = True

    # TODO: Ownership

    module.exit_json(**result)

if __name__ == '__main__':
    main()
