# vim: set filetype=sh
# Environmental variables for zsh
export ZDOTDIR=$HOME/.config/zsh
export TERMCMD=xterm
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.bin:$HOME/local/bin:$HOME/.bin/statusbar:$PATH"
export EDITOR=nvim
export BROWSER=waterfox-g4
export CALCULATOR=galculator
export BUS_BROWSER=chromium
export CDPATH=~/.shortcut_dirs
[ -x "$(command -v st)" ] && export TERMINAL="st"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_DIRS="/usr/local/share:/usr/share:$HOME/.local/share"
export XDG_CONFIG_DIRS="/etc/xdg"
export VIMINIT='source $XDG_CONFIG_HOME/nvim/init.vim'

# make fzf not follow symbolic links
export FZF_DEFAULT_COMMAND='rg --files --hidden --no-ignore-vcs'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
#
export VIRSH_DEFAULT_CONNECT_URI=qemu:///system
# set username for wine
export WINEUSERNAME=combat1921
export GST_PLUGIN_SYSTEM_PATH_1_0="$HOME/.steam/steam/compatibilitytools.d/Proton-5.21-GE-1/dist/lib64/gstreamer-1.0:$HOME/.steam/steam/compatibilitytools.d/Proton-5.21-GE-1/dist/lib/gstreamer-1.0"
#source personal environment variables
source $HOME/.config/bash/private_env
source $HOME/.config/bemenu/bemenu_conf
export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# Load pyenv into the shell by adding
# the following to ~/.zshrc:

eval "$(pyenv init -)"

# RADV = mesa, AMDVLK = amd vulkan 
export AMD_VULKAN_ICD=RADV
# certain programs want the python in PATH to be native
function native_python(){
        export PATH="/usr/bin:$PATH"
}
export JAVA_HOME=/usr/lib/jvm/java-16-openjdk
alias psp=PPSSPPSDL
export $(dbus-launch)
