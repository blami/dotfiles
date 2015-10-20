# ~/.zshrc: Zsh resource file

# {{{ Helper functions 
# }}}


# {{{ General
setopt nobeep                               # disable beeps
setopt nomail_warning                       # don't check mail file change

# Input/output
bindkey -e                                  # use Emacs-style keybindings

setopt noflow_control                       # disallow ^S/^Q in shell editor
setopt interactive_comments                 # allow comments also in shell
# }}}


# {{{ History
setopt append_history                       # append history
setopt extended_history                     # log start and duration time
setopt histignorespace                      # don't log space-prefixed lines
setopt share_history                        # share history across the sessions
setopt histignorealldups                    # ignore duplicates

# History file
HISTSIZE=1000                               # history kept in session
SAVEHIST=1000                               # history saved to .zsh_history
HISTFILE=$HOME/.zsh_history.$HOST
# }}}


# {{{ Globbing and directory changes
setopt extended_glob                        # treat #~^ as patterns
setopt noglobdots                           # don't glob dots

setopt auto_cd                              # change directory without cd
setopt auto_pushd                           # push the dir on stack on cd
setopt pushd_ignore_dups                    # don't push the same dir twice

# Directory stack file
DIRSTACKSIZE=100
DIRSTACKFILE=$HOME/.zsh_dirs.$HOST
# }}}


# {{{ Jobs
setopt notify                               # report status of bg jobs
setopt longlistjobs                         # list PID on ^Z
setopt bg_nice                              # run bg jobs with lower priority
setopt check_jobs                           # report status of bg jobs on exit
setopt nohup                                # don't HUP processes when exiting

REPORTTIME=5                                # report load when run takes >5s
# }}}


# Source aliases
source $HOME/.sh_aliases


# {{{ Prompt
# Prompt widgets


# Prompt theming
autoload -Uz promptinit
promptinit
prompt adam1
# }}}


# {{{ Completion
# }}}


# Local configuration



setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi


# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
