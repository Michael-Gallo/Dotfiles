abbr :q exit
abbr vim nvim
abbr svim sudoedit
abbr df "df -h"
abbr --position=anywhere du "du -h"
abbr --position=anywhere mkdir "mkdir -pv"
abbr lo libreoffice
abbr pm pcmanfm
abbr yp "yadm push"
abbr ys "yadm status"
abbr ya "yadm add"
abbr yc 'yadm commit'
abbr gp "git push"
abbr gs "git status"
abbr gcp "git cherry-pick"
abbr gco "git checkout"
abbr gc "git commit"
abbr gpoh "git push -u origin HEAD"
abbr pac "sudo pacman"
abbr gmt "go mod tidy"
abbr tf tofu
abbr mirrors "rate-mirrors --allow-root --protocol https arch | sudo tee /etc/pacman.d/mirrorlist"
abbr inv 'fzf --preview="bat --color=always {}" --bind "enter:become($EDITOR {})"'

# Conditional ls abbr
if command -v eza >/dev/null
    set -l opts --color=always --group-directories-first --git --icons
    abbr ls "eza $opts"
    abbr ll "eza -l $opts"
    abbr la "eza -a $opts"
end