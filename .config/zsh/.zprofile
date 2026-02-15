# XDG
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_DIRS="/etc/xdg"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_DIRS="/usr/local/share:/usr/share:$HOME/.local/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_MUSIC_DIR="$HOME/Music"
export XDG_PICTURES_DIR="$HOME/Pictures"
export XDG_SCREENSHOTS_DIR="$HOME/Pictures/screenshots"
export XDG_STATE_HOME="$HOME/.local/state"

# Toolchains
export GOPATH="$HOME/go"
export ANDROID_HOME=/home/mike/Android/Sdk
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk

# python
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# misc env vars
export CDPATH=~/.shortcut_dirs
