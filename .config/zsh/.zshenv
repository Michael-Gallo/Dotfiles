# vim: set filetype=sh
# Environmental variables for zsh
export BROWSER=zen-browser
export CALCULATOR=galculator
export CALENDAR=evolution
export CDPATH=~/.shortcut_dirs
export EDITOR=nvim
export FILE_MANAGER=pcmanfm
export FZF_DEFAULT_OPTS='--preview="bat --style=numbers --color=always {}"'
export PATH="$HOME/.bin/statusbar:$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.bin:$HOME/local/bin:/var/lib/flatpak/exports/bin:$HOME/Apps:/opt/android-sdk/platform-tools:$PATH"
export TERMCMD=xterm
export TERMINAL_FILE_BROWSER=lf
export VIMINIT='source $XDG_CONFIG_HOME/nvim/init.lua'
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_DIRS="/etc/xdg"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_DIRS="/usr/local/share:/usr/share:$HOME/.local/share:/var/lib/flatpak/exports/share:/home/mike/local/share/flatpak/exports/share"
export XDG_DATA_HOME="$HOME/local/share"
export XDG_MUSIC_DIR="$HOME/Music"
export XDG_PICTURES_DIR="$HOME/Pictures"
export XDG_SCREENSHOTS_DIR="$HOME/Pictures/screenshots"
export ZDOTDIR=$HOME/.config/zsh
# Golang
export GOPATH="$HOME/go"
export PATH="$HOME/go/bin:$PATH"

# Python
# Load pyenv into the shell by adding
# the following to ~/.zshrc:

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"


export TERMINAL="foot"
# Display protocol specific env vars
case $XDG_SESSION_TYPE in
        "x11")
                [ -x "$(command -v st)" ] && export TERMINAL="st"
                export RUN_LAUNCHER="dmenu_run"
                export BUS_BROWSER="brave"
                export MENU="dmenu"
                export WMBLOCKS="dwmblocks"

        ;;
        # Wayland by default
        *)
                export ELECTRON_OZONE_PLATFORM_HINT=wayland
                export TERMINAL="foot"
                export RUN_LAUNCHER="bemenu-run"
                export MENU="bemenu"
                export BUS_BROWSER="brave"
                export MOZ_ENABLE_WAYLAND=1
                export WMBLOCKS="someblocks"
                export GDK_BACKEND="wayland"
        ;;
esac




# make fzf not follow symbolic links
export FZF_DEFAULT_COMMAND='rg --files --hidden --no-ignore-vcs'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export QT_QPA_PLATFORMTHEME=qt6ct
#
# set username for wine
export WINEUSERNAME=combat1921
#source personal environment variables
if [ -f $HOME/.config/zsh/private_env ]; then
    source $HOME/.config/zsh/private_env
else
    touch $HOME/.config/zsh/private_env
fi
source $HOME/.config/bemenu/bemenu_conf


# RADV = mesa, AMDVLK = amd vulkan 
export AMD_VULKAN_ICD=RADV
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk
alias psp=PPSSPPSDL
# export $(dbus-launch)

export GTK_MODULES=canberra-gtk-module
export GTK3_MODULES=xapp-gtk3-module
export ZDOTDIR=$HOME/.config/zsh
source "/home/mike/.rover/env"
if [ -f ~/.config/bash/bash_aliases  ]; then
    source ~/.config/bash/bash_aliases
fi

export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export GLFW_IM_MODULE=ibus
export SDL_IM_MODULE=fcitx
export ANDROID_HOME=/home/mike/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
