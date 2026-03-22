if status is-interactive
    fish_add_path -g ~/.bin
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
    if fish_vcs_prompt
        set_color 87afff
        printf '%s' (fish_vcs_prompt)
        set_color normal
    end
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
if functions -q fzf_configure_bindings
fzf_configure_bindings \
    --history=\cr \
    --directory=\ct \
    --git_log=\cl \
    --git_status=\cs \
    --variables=\cv \
    --processes=\cp
end

