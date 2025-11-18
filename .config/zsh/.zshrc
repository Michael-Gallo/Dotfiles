### Set variables
#################
bindkey -e
HISTFILE=$HOME/.config/zsh/.zhistory
HISTSIZE=1000000
SAVEHIST=$HISTSIZE
HOSTNAME=$HOSTNAME

# Add Git to prompt
autoload -Uz add-zsh-hook vcs_info
setopt prompt_subst
add-zsh-hook precmd vcs_info
zstyle ':vcs_info:git:*' formats       ' (%b%u%c) '
zstyle ':vcs_info:git:*' actionformats ' (%b|%a%u%c) '

PROMPT='%F{35}%n%f:%F{35}%~%f%F{135}${vcs_info_msg_0_}%f$ '

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"


# Basic auto/tab complete:
zstyle ':completion:*' menu select
zmodload zsh/complist
_comp_options+=(globdots)		# Include hidden files.


# enable command auto-correction.
setopt correct

# Automatic directory changing
setopt auto_cd

# Lazy-load antidote.
source '/usr/share/zsh-antidote/antidote.zsh'
antidotePath=/usr/share/zsh-antidote

zsh_plugins=${ZDOTDIR:-~}/.zsh_plugins
# Generate static file in a subshell when .zsh_plugins.txt is updated.
if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
    (
    antidote load
    antidote bundle <${zsh_plugins}.txt >${zsh_plugins}.zsh
)
fi
# Source static plugins file.
source $zsh_plugins.zsh

###### User configuration #####

# Bash Aliases
if [ -f ~/.config/bash/bash_aliases  ]; then
    source ~/.config/bash/bash_aliases
fi


export KEYTIMEOUT=1

local copy_widgets=(
    vi-yank vi-yank-eol vi-delete vi-backward-kill-word vi-change-whole-line
)
local paste_widgets=(
    vi-put-{before,after}
)

bindkey '^K' autosuggest-accept
# doubletap escape for sudo

# make aliases work with sudo
alias sudo='sudo '
alias orphans='sudo pacman -R $(pacman -Qdtq)'


source <(fzf --zsh)

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

zstyle ':plugin:ez-compinit' 'compstyle' 'zshzoo'

# Load syntax highlighting; should be last.
ZSH_AUTOSUGGEST_USE_ASYNC="TE"
ZSH_AUTOSUGGEST_HISTORY_IGNORE="kill*"


bindkey "\e[1;3D" backward-word
bindkey "\e[1;3C" forward-word
