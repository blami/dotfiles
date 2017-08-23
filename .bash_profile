# ~/.bash_profile: bash resource file
# NOTE: this file is sourced by login shells

# Source .bashrc to have same environment in login and non-login shells
source $HOME/.bashrc

# Login script (run only in login shells)
[ -r $HOME/.sh_login ] && source $HOME/.sh_login
