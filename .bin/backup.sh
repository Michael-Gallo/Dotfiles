#!/bin/sh

# Backup script using rsync to send directories to NAS

ANIME_FOLDER="/mnt/storage/Anime/"
ANIME_BACKUP="/mnt/nas/anime"

mount $ANIME_BACKUP
rsync -urv --progress $ANIME_FOLDER $ANIME_BACKUP
