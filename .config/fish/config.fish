if status is-interactive
    fish_add_path -g ~/.bin
    fish_add_path -g ~/go/bin
    fish_add_path -g ~/.local/share/gem/ruby/3.4.0/bin
    fish_add_path -g ~/.local/bin
    pyenv init - fish | source
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
    set -l vcs (fish_vcs_prompt)
    if test -n "$vcs"
        set_color 87afff
        printf '%s' $vcs
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

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/mike/google-cloud-sdk/path.fish.inc' ]; . '/home/mike/google-cloud-sdk/path.fish.inc'; end
