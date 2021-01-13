### Set variables
#################
HISTFILE=$HOME/.config/zsh/.zhistory
HISTSIZE=1000
SAVEHIST=1000
HOSTNAME="$(hostname)"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="candy-kingdom"
# autoload -U colors && colors	# Load colors
autoload -U compinit && compinit
PROMPT="%F{35}%n%f:%F{35}%~%f$ "

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"


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


source /usr/share/zsh/share/antigen.zsh
# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle themes
antigen bundle pip
antigen bundle autojump
antigen bundle sudo
antigen bundle command-not-found
antigen bundle fzf
antigen bundle softmoth/zsh-vim-mode
antigen bundle zdharma/fast-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle colored-man-pages
# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

antigen apply

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

