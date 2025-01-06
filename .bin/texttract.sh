#!/bin/sh

# all game prefix data is here
GAME_PATH_BASE="/mnt/storage/games/SteamLibrary/steamapps/compatdata/"
# Same as game id in steam
prefix_id=$1
textractor_arch=$2
proton_version="GE-Proton9-21"

if [ -z $textractor_arch ]; then
    echo "textractor architecture not set, assuming x64"
    textractor_arch=x64
fi

if [ $textractor_arch != "x86" ] && [ $textractor_arch != "x64" ]; then
    echo "textractor_arch must be set to either x64 or x86, is currently set to $textractor_arch"
    exit 1
fi


TEXTRACTOR_EXECUTABLE="/home/mike/.wine/drive_c/users/mike/Desktop/Textractor/$textractor_arch/Textractor.exe"

if [ ! -f $TEXTRACTOR_EXECUTABLE ]; then
    echo "invalid textractor executable $TEXTRACTOR_EXECUTABLE"
    exit 1 
fi

proton_executable="/home/mike/.steam/steam/compatibilitytools.d/$proton_version/proton"
if [ -f proton_executable ]; then
    echo "invalid proton executable $proton_executable"
    exit 1
fi

if [ -z $prefix_id ]; then
    echo "Need Prefix id"
    exit 1
fi

game_path=$GAME_PATH_BASE$prefix_id

if [ ! -d $game_path ]; then
    echo "Game path $game_path does not exist"
    exit 1
fi


WINEPREFIX=$game_path/pfx STEAM_COMPAT_DATA_PATH=$game_path $proton_executable runinprefix $TEXTRACTOR_EXECUTABLE
