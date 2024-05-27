# Ansible

This directory Ansible playbooks, roles and other support files I use to manage
my personal hosts.

**CAUTION:** This is not usual fleet management playbook, but rather
amateur-made structured replacement of opinionated rando shell scripts used to
make host bearable for me. Please DON'T USE THIS AS IS unless you are me.

# Usage

## Variables
* `all.yml:cache_dir=/var/cache/ansible` - cached files between runs



## Vocab
* `control node` - where playbook runs
* `managed node` - where playbook changes things
* **Linux world**
* **Windows world**


# Contributing

## Naming
* If not prefixed its Linux world, if prefixed with `win_` its Windows world.
  In case of _task_ files an exception is made if its convenient to have one
  file handling both worlds (e.g. `tasks/pre_user.yml`); same rule applies to
  most facts and vars except `is_*` and `has_*` ones.

## Structure
* `scripts\`            - scripts run from within the playbook(s)
* `tasks\`              - tasks outside roles
  * `pre_*.yml`
  * `post_*.yml`
* `roles\`
  * [`os\`][os]         - role that sets up operating system

## WSL
* Anything that calls `exe` from Linux world needs to be guarded by:
  ```yaml
  - is_wsl
  - has_wsl_interop
  ```
