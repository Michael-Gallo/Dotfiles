#!/bin/sh

# use rclone to encrypt and backup my folders


# Cloud storage
cloud_remote=crypt
rclone sync --transfers 32 /mnt/storage/Music $cloud_remote/Music
rclone sync --transfers 32 /mnt/storage/Documents $cloud_remote/Documents
rclone sync --transfers 32 /mnt/storage/Pictures $cloud_remote/Pictures

local_remote=nas:backup
rclone sync --transfers=32 /mnt/storage/Music $local_remote/Music
rclone sync --transfers=32 /mnt/storage/Documents $local_remote/Documents
rclone sync --transfers=32 /mnt/storage/Pictures $local_remote/Pictures

