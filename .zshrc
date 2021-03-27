### Set variables
#################
HISTFILE=$HOME/.config/zsh/.zhistory
HISTSIZE=1000
SAVEHIST=1000
HOSTNAME="$(hostname)"

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


# enable command auto-correction.
setopt correct

# Automatic directory changing
setopt auto_cd



# install ZSH plugins
source ~/.config/zsh/zsh_plugins.sh

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

eval "$(pyenv init -)"
