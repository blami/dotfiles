# ~/.zshrc - Zsh resource file

# {{{ General
setopt nobeep                               # Disable beeps
setopt nomail_warning                       # Don't check mail file change

# Function path
# NOTE Add all uppercasse starting subdirectories in ~/.zsh to FPATH
if [ -d $HOME/.zsh ]; then
    for fdir in $HOME/.zsh/[[:upper:]]*; do
        [ -d $fdir ] && fpath=($fdir $fpath)
    done
fi

# Input/output
# Keybindings
bindkey -e                                  # Use Emacs-style keybindings
# NOTE Zsh does not read inputrc (so we need to do same keybindings here)
bindkey "\e[1~"		beginning-of-line       # Home: BOL
bindkey "\e[7~"		beginning-of-line
bindkey "\eOH"		beginning-of-line
bindkey "\e[H"		beginning-of-line
bindkey "\e[4~"		end-of-line             # End: EOL
bindkey "\e[8~"		end-of-line
bindkey "\eOF"		end-of-line
bindkey "\e[F"		end-of-line
bindkey "\e[3~"		delete-char             # Del, Backspace: delete character
bindkey "\e\e"		kill-whole-line         # Esc-Esc: clear line

setopt noflow_control                       # Disallow ^S/^Q in shell editor
setopt interactive_comments                 # Allow comments also in shell
# }}}


# {{{ History
setopt append_history                       # Append history
setopt extended_history                     # Log start and duration time
setopt histignorespace                      # Don't log space-prefixed lines
setopt share_history                        # Share history across the sessions
setopt histignorealldups                    # Ignore duplicates

# History file
HISTSIZE=1000                               # History kept in session
SAVEHIST=1000                               # History saved to .zsh_history
HISTFILE=$HOME/.zsh_history.$HOST
# }}}


# {{{ Globbing and directory changes
setopt extended_glob                        # Treat #~^ as patterns
setopt noglobdots                           # Don't glob dots

setopt auto_cd                              # Change directory without cd
setopt auto_pushd                           # Push the dir on stack on cd
setopt pushd_ignore_dups                    # Don't push the same dir twice

# Directory stack file
DIRSTACKSIZE=100
DIRSTACKFILE=$HOME/.zsh_dirs.$HOST
# }}}


# {{{ Jobs
setopt notify                               # Report status of bg jobs
setopt longlistjobs                         # List PID on ^Z
setopt bg_nice                              # Run bg jobs with lower priority
setopt check_jobs                           # Report status of bg jobs on exit
setopt nohup                                # Don't HUP processes when exiting

REPORTTIME=5                                # Report load when run takes >5s
# }}}


# Source aliases
source $HOME/.sh_aliases


# {{{ Hooks
# Set terminal title to ZSH[ws]: [user@host] ~
function hook_term_title() {
	print -Pn "\e]0;ZSH: [%n@%m] %~\a"
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd     hook_term_title     # Change terminal title
# }}}


# {{{ Prompt
setopt prompt_subst
autoload -Uz promptinit
promptinit
prompt blami
# }}}


# {{{ Completion
# }}}


# Local configuration
