#!/bin/sh
# Crontab will look something like:
# 0 6 * * * /usr/binparallel /home/mike/.bin/backup.sh ::: cloud nas

# Parallel's output is only sane if you use --ungroup
# parallel --tag --ungroup b2.sh ::: cloud nas 


cloud_remote=b2crypt:
local_remote=nas:backup
target=$1
if [[ "$target" == "cloud" ]]; then
   remote=$cloud_remote
elif [[ "$target" == "nas" ]]; then
    remote=$local_remote
else
    echo "Invalid target: $target please use cloud or nas"
    exit 1
fi


backup() {
    local name=$1 src=$2
    echo "$name to $target"
    if ! rclone sync --skip-links --transfers 32 "$src" "$remote/$name"; then
        notify-send -u critical "Backup Failed" "$name sync failed"
        exit 1
    fi
}

    
backup "Music" "/mnt/storage/Music"
backup "Documents" "/mnt/storage/Documents"
backup "Pictures" "/mnt/storage/Pictures"


echo "Done transfering to $target"
