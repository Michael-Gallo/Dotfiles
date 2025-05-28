# increases key speed 
#xset r rate 300 50 
# uses whatever environmental variables are set in bash_env
if [ -f ~/.zshenv  ]; then
        source ~/.zshenv
fi

export QT_STYLE_OVERRIDE=kvantum

if [ -z "$SSH_AGENT_PID" ]; then
  eval "$(ssh-agent -s)" > /dev/null
fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
