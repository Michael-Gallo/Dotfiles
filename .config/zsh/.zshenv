# vim: set filetype=sh
# Environmental variables for zsh

export ANDROID_HOME=$HOME/Android/Sdk
typeset -U path

path=(
  "$HOME/.local/bin"
  "$HOME/.cargo/bin"
  "$HOME/.bin"
  "/var/lib/flatpak/exports/bin"
  "$HOME/Apps"
  "/opt/android-sdk/platform-tools"
  "$HOME/go/bin"
  "$ANDROID_HOME/emulator"
  "$ANDROID_HOME/platform-tools"
  $path
)
export PATH
export WINEUSERNAME=combat1921
export ZDOTDIR=$HOME/.config/zsh



# RADV = mesa, AMDVLK = amd vulkan 
export AMD_VULKAN_ICD=RADV

# Controller settings, this is used so that the 8bitdo ultimate, that gets recognized as a Switch controller, behaves as if their buttons were in the superior Xbox layout
export SDL_GAMECONTROLLERCONFIG="030077557e0500000920000000026803,*,a:b1,b:b0,back:b4,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,dpup:h0.1,guide:b5,leftshoulder:b9,leftstick:b7,lefttrigger:a4,leftx:a0,lefty:a1,rightshoulder:b10,rightstick:b8,righttrigger:a5,rightx:a2,righty:a3,start:b6,x:b3,y:b2,misc1:b11,crc:5577,platform:Linux,"

