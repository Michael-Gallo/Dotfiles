#!/usr/bin/fish


# run once on new machine, sets universal vars
set -Ux XDG_CACHE_HOME $HOME/.cache
set -Ux XDG_CONFIG_DIRS /etc/xdg
set -Ux XDG_CONFIG_HOME $HOME/.config
set -Ux XDG_DATA_DIRS /usr/local/share:/usr/share:$HOME/.local/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share
set -Ux XDG_DATA_HOME $HOME/.local/share
set -Ux XDG_MUSIC_DIR $HOME/Music
set -Ux XDG_PICTURES_DIR $HOME/Pictures
set -Ux XDG_SCREENSHOTS_DIR $HOME/Pictures/screenshots
set -Ux XDG_STATE_HOME $HOME/.local/state
set -Ux FZF_DEFAULT_OPTS '--preview "bat --color=always {}"'
set -Ux fzf_fd_opts --hidden --exclude .git
