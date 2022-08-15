# vim: set filetype=sh
# Environmental variables for zsh
export ZDOTDIR=$HOME/.config/zsh
export PATH="$HOME/.bin/statusbar:$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.bin:$HOME/local/bin:/var/lib/flatpak/exports/bin:$PATH:$HOME/Apps"
export EDITOR=nvim
export CDPATH=~/.shortcut_dirs
[ -x "$(command -v st)" ] && export TERMINAL="st"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_DIRS="/usr/local/share:/usr/share:$HOME/.local/share:/var/lib/flatpak/exports/share:/home/mike/local/share/flatpak/exports/share"
export XDG_CONFIG_DIRS="/etc/xdg"
export XDG_PICTURES_DIR="$HOME/Pictures"
export XDG_SCREENSHOTS_DIR="$HOME/Pictures/screenshots"
export VIMINIT='source $XDG_CONFIG_HOME/nvim/init.vim'
source $HOME/.cache/bwsession


# make fzf not follow symbolic links
export FZF_DEFAULT_COMMAND='rg --files --hidden --no-ignore-vcs'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
