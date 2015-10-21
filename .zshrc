# ~/.zshrc: Zsh resource file

# {{{ Helper functions
# NOTE Functions here are prefixed with usr_.

# Set terminal title to ZSH[ws]: user@host <dir>
function hook_term_title() {
	print -Pn "\e]0;ZSH: %n@%m %~\a"
}
# }}}


# {{{ General
setopt nobeep                               # Disable beeps
setopt nomail_warning                       # Don't check mail file change

# Input/output
bindkey -e                                  # Use Emacs-style keybindings

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
autoload -Uz add-zsh-hook
add-zsh-hook precmd hook_term_title         # Change terminal title

# }}}


# {{{ Prompt
setopt prompt_subst

# Prompt widgets


# Prompt
autoload -Uz promptinit
promptinit
prompt adam1
# }}}


# {{{ Completion
# }}}


# Local configuration



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
