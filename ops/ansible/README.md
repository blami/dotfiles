# Ansible

These are my personal Ansible playbook(s) and Ansible extensions to setup
my machines. **Playbooks are mostly meant to be run locally on the computer
itself to set it up**. This is not usual fleet management script, but closest
"structured" replacement of rando shellscripts that I used to have.

In my day to day life I deal with multiple operating systems and versions of
them, most prominent setups being:

* Microsoft Windows 11 + Debian GNU/Linux (in WSL2)
* Debian GNU/Linux
* Microsoft Windows 10 + RedHat Enterprise Linux 8+ (in WSL2)


## Usage
This repository contains one monster `play.yml` which has a lot of roles, most
of which are set to `never` play. I further control what I want done on each
host by intricate use of `--tags` and `--skip-tags` (and also `-e var=VALUE`).


## Organization
I deal 


## Disclaimer
**Disclaimer:** as the rest of repository **this is not meant to be used
as-is** (unless you are me). It is rather for inspiration and/or partial reuse.
