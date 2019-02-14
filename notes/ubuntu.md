Ubuntu
======
This document contains various useful notes for Ubuntu Linux.


Configuration
=============

Sudoers
-------
To make ``sudo`` work as in original Ubuntu versions (keeping user $HOME and
environment while being sudoed to root) run:

- `# visudo`
- Change `Defaults env_reset` to `Defaults !env_reset`
- Change `Defaults env_keep += "HOME"`
