### Set variables
#################
HISTFILE=$HOME/.config/zsh/.zhistory
HISTSIZE=1000
SAVEHIST=1000
HOSTNAME="$(hostname)"
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$HOME/.config/zsh"
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="candy-kingdom"
# autoload -U colors && colors	# Load colors
autoload -U compinit && compinit
PROMPT="%F{35}%n%f:%F{35}%~%f$ "

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"


# Basic auto/tab complete:
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"
DISABLE_AUTO_UPDATE="true"
# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# enable command auto-correction.
ENABLE_CORRECTION="true"


# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"


# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git
        themes
        pip
        autojump
        sudo
        command-not-found
        fzf
        # Enable better vim mode
        zsh-vim-mode
        fast-syntax-highlighting
        zsh-autosuggestions
        )

source $ZSH/oh-my-zsh.sh


###### User configuration #####

# Bash Aliases
if [ -f ~/.config/bash/bash_aliases  ]; then
    source ~/.config/bash/bash_aliases
fi
# Environmental variables in their own config file

if [ -f ~/.config/bash/bash_env  ]; then
    source ~/.config/bash/bash_env
fi


# vi mode
bindkey -v
set -o vi
export KEYTIMEOUT=1
# turnoff vi prompt added in from zsh-vim-mode
RPS1=""
### Attempt to make it use clipboard
function x11-clip-wrap-widgets() {
    # NB: Assume we are the first wrapper and that we only wrap native widgets
    # See zsh-autosuggestions.zsh for a more generic and more robust wrapper
    local copy_or_paste=$1
    shift

    for widget in $@; do
        # Ugh, zsh doesn't have closures
        if [[ $copy_or_paste == "copy" ]]; then
            eval "
            function _x11-clip-wrapped-$widget() {
                zle .$widget
                xclip -in -selection clipboard <<<\$CUTBUFFER
            }
            "
        else
            eval "
            function _x11-clip-wrapped-$widget() {
                CUTBUFFER=\$(xclip -out -selection clipboard)
                zle .$widget
            }
            "
        fi

        zle -N $widget _x11-clip-wrapped-$widget
    done
}

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

local copy_widgets=(
    vi-yank vi-yank-eol vi-delete vi-backward-kill-word vi-change-whole-line
)
local paste_widgets=(
    vi-put-{before,after}
)

# NB: can atm. only wrap native widgets
x11-clip-wrap-widgets copy $copy_widgets
x11-clip-wrap-widgets paste  $paste_widgets
# Load syntax highlighting; should be last.


ZSH_AUTOSUGGEST_USE_ASYNC="TE"
ZSH_AUTOSUGGEST_HISTORY_IGNORE="kill*"
bindkey '^K' autosuggest-accept
# doubletap escape for sudo

