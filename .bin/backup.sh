#!/bin/sh
# Crontab will look something like:
# 0 6 * * * /usr/binparallel /home/mike/.bin/backup.sh ::: cloud nas

# Parallel's output is only sane if you use --ungroup
# parallel --tag --ungroup b2.sh ::: cloud nas 


cloud_remote=encrypted-mg-backup-bucket:
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


# Cloud storage

echo "Music to $target" && rclone sync --skip-links --transfers 32 /mnt/storage/Music $remote/Music
echo "Documents to $target" && rclone sync --skip-links --transfers 32 /mnt/storage/Documents $remote/Documents
echo "Pictures to $target" &&  rclone sync --skip-links --transfers 32 /mnt/storage/Pictures $remote/Pictures


echo "Done transfering to $target"
