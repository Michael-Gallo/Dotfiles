if status is-interactive
    # Commands to run in interactive sessions can go here
end

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
