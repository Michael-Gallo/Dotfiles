if status is-interactive
    # Commands to run in interactive sessions can go here
    set -x FZF_DEFAULT_OPTS '--preview "bat --color=always {}"'
    set -Ux fzf_fd_opts --hidden --exclude .git
end

set -g fish_greeting

function fish_prompt
    set_color 28a745
    printf '%s' $USER
    set_color normal
    printf ':'
    set_color 28a745
    printf '%s' (prompt_pwd)
    set_color normal
    set_color 87afff
    printf '%s' (fish_vcs_prompt)
    set_color normal
    printf '$ '
end
# Warn if fisher is missing
if not functions -q fisher
    echo "fisher not installed. Run: curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
end

function update-fish-plugins
    fisher update
end
# configure fzf binds
fzf_configure_bindings \
    --history=\cr \
    --directory=\ct \
    --git_log=\cl \
    --git_status=\cs \
    --variables=\cv \
    --processes=\cp


set -gx XDG_CACHE_HOME $HOME/.cache
set -gx XDG_CONFIG_DIRS /etc/xdg
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_DIRS /usr/local/share:/usr/share:$HOME/.local/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_MUSIC_DIR $HOME/Music
set -gx XDG_PICTURES_DIR $HOME/Pictures
set -gx XDG_SCREENSHOTS_DIR $HOME/Pictures/screenshots
set -gx XDG_STATE_HOME $HOME/.local/state
