Dotfiles
========
This repository contains my ~ dotfiles. It is not meant to clone and use as-is
but can be useful as an inspiration in some cases.

Mostly I use this on several Debian/Ubuntu machines, but also on Solaris 11+
boxes at work and in Cygwin environment on my Microsoft Windows 10 machine.

I usually clone whole repository to ~/dotfiles and then copy over. To manage I
use my own alias dfgit which sets --git-dir to .dfgit to not interfere with
shell plugins for real-git repos, IDEs, etc.

If you have any questions or comments, you're welcome to leave message here on
BitBucket/Github or send me an e-mail or on Twitter @blami.

Happy hacking!


Shell Configuration
-------------------
My shell of choice is Zsh but I'm not that lucky to have it everywhere I
login. So I'm rolling also decent Bash configuration (I'm happy if I have my
bunch of aliases and environment set there). On machines where I have Bash as
login shell there's a small 'hack' in my .bash_profile which tries to detect
Zsh and run it as login sub-shell. This is mostly because I don't want to set
Zsh as my primary shell in work LDAP as there's many boxes with Bash only.

Most of inter-shell configuration is stored in .sh_* files which are then
sourced from various Zsh- or Bash- specific rc files.

I also have a couple of ~/.profile.d files which I originally rolled in my /etc
but since I'm working with lot of boxes where I can't put these into
/etc/profile.d I decided to have them as part of my ~/profile.

venv/venv3 aliases
~~~~~~~~~~~~~~~~~~
These aliases either create Python/Python3 virtual environment in current
directory and then switch to it or just use existing one matching operating
system and architecture (as compiled .so's or even binaries live in venv). I
find this very useful when switching between Linux i386/amd64 and Solaris
x86pc/sparc.

SSH Agent
~~~~~~~~~
SSH agent environment lives in ~/.sshagent. Optionally unlocks your id_rsa or
different key after first use of ssh alias...


Vim Configuration
-----------------
I love Vim and use it for daily work.


Screen
------


$_sh_<FILE>_sourced guards are unset at the end of shell startup
