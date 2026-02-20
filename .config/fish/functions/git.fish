function yc
    if test -z $argv[1]
        yadm status | grep modified: | awk '{print $2}' | fzf | xargs yadm commit
    else
        yadm commit $argv
    end
end

function yd
    set file (yadm status | grep modified: | awk '{print $2}' | fzf)
    if test -z "$file"
        echo "No file selected"
        return
    end
    yadm --no-pager diff "$file"

    echo "Do you want to commit this file? [y/N]"
    read -l answer
    if string match -qr '^[Yy]$' $answer
        yadm commit "$file"
    else
        echo "commit cancelled"
    end
end

function gd
    git status | grep modified: | awk '{print $2}' | fzf | xargs git diff
end
