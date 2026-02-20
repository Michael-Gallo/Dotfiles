abbr :q exit
abbr mkd "mkdir -pv"
abbr --position=anywhere grep "grep --color=auto"
abbr --position=anywhere fgrep "fgrep --color=auto"
abbr --position=anywhere egrep "egrep --color=auto"
abbr ll "ls -alF"
abbr la "ls -A"
abbr vim nvim
abbr svim sudoedit
abbr df "df -h"
abbr --position=anywhere mkdir "mkdir -pv"
abbr lo libreoffice
abbr pm pcmanfm
abbr yp "yadm push -f"
abbr ys "yadm status"
abbr ya "yadm add"
abbr gp "git push -f"
abbr gs "git status"
abbr gcp "git cherry-pick"
abbr gpoh "git push origin HEAD"
abbr pac "sudo pacman"
abbr --position=anywhere du "du -h"
abbr --position=anywhere nmap "nmap -sn"
abbr gmt "go mod tidy"
abbr tf terraform
abbr mirrors "rate-mirrors --allow-root --protocol https arch | sudo tee /etc/pacman.d/mirrorlist"
abbr inv 'fzf --preview="bat --color=always {}" --bind "enter:become($EDITOR {})"'

# Conditional abbr
if command -v exa >/dev/null
    abbr ls "exa -a --color=always --group-directories-first --git --icons"
end
