# uncomment this line if perf testing
# zmodload zsh/zprof
### Set variables
#################
bindkey -e
HISTFILE=$HOME/.config/zsh/.zhistory
HISTSIZE=1000000
SAVEHIST=$HISTSIZE

# Add Git to prompt
autoload -Uz add-zsh-hook vcs_info
setopt prompt_subst
add-zsh-hook precmd vcs_info
zstyle ':vcs_info:git:*' formats       ' (%b%u%c) '
zstyle ':vcs_info:git:*' actionformats ' (%b|%a%u%c) '

PROMPT='%F{35}%n%f:%F{35}%~%f%F{135}${vcs_info_msg_0_}%f$ '

export MANPAGER="sh -c 'col -bx | bat -l man -p'"
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

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
# Lazy-load antidote.
source '/usr/share/zsh-antidote/antidote.zsh'

zsh_plugins=${ZDOTDIR:-~}/.zsh_plugins
[[ -f ${zsh_plugins}.txt ]] || touch ${zsh_plugins}.txt

# Lazy-load antidote from its functions directory.
fpath=(/path/to/antidote/functions $fpath)
autoload -Uz antidote

# Generate a new static file whenever .zsh_plugins.txt is updated.
if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
  antidote bundle <${zsh_plugins}.txt >|${zsh_plugins}.zsh
fi

# Source your static plugins file.
source ${zsh_plugins}.zsh

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


# lazy load python# ---- Lazy pyenv loader ----
_pyenv_lazy_init() {
  unset -f pyenv python pip pip3

  eval "$(pyenv init -)"

  # Re-run the original command
  command "$@"
}

pyenv()  { _pyenv_lazy_init pyenv  "$@"; }
python() { _pyenv_lazy_init python "$@"; }
pip()    { _pyenv_lazy_init pip    "$@"; }
pip3()   { _pyenv_lazy_init pip3   "$@"; }
# python done

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
path+=("$HOME/.rvm/bin")

zstyle ':plugin:ez-compinit' 'compstyle' 'zshzoo'

# Load syntax highlighting; should be last.
ZSH_AUTOSUGGEST_USE_ASYNC="TE"
ZSH_AUTOSUGGEST_HISTORY_IGNORE="kill*"
#source personal environment variables
[ -f "$HOME/.config/zsh/private_env" ] && source "$HOME/.config/zsh/private_env"

bindkey "\e[1;3D" backward-word
bindkey "\e[1;3C" forward-word


# make fzf not follow symbolic links
export FZF_DEFAULT_OPTS='--preview="bat --style=numbers --color=always {}"'
export FZF_DEFAULT_COMMAND='rg --files --hidden --no-ignore-vcs'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Lazy-load fzf sources but keep widgets functional
_fzf_lazy_source() {
  [ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
  [ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
  unset -f _fzf_lazy_source
}

# Wrap fzf widgets to trigger lazy load on first use
fzf-history-widget() {
  _fzf_lazy_source
  zle fzf-history-widget
}
zle -N fzf-history-widget

fzf-file-widget() {
  _fzf_lazy_source
  zle fzf-file-widget
}
zle -N fzf-file-widget

fzf-cd-widget() {
  _fzf_lazy_source
  zle fzf-cd-widget
}
zle -N fzf-cd-widget

# Bind keys after widgets are defined
bindkey '^R' fzf-history-widget
bindkey '^T' fzf-file-widget
bindkey '\ec' fzf-cd-widget

# uncomment this line if perf testing
# zprof
