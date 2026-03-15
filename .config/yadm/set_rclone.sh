#!/usr/bin/env bash
set -euo pipefail

# Bitwarden has a punycode issue that results in warnings that break jq
export NODE_NO_WARNINGS=1

RCLONE_DIR="$HOME/.config/rclone"
BW_ITEM_NAME="rclone-backblaze-secrets"

echo "Filling Rclone config"

mkdir -p $RCLONE_DIR
chmod 700 $RCLONE_DIR

export BW_SESSION=$(bw unlock --raw)
echo "BitWarden Unlocked"
eval "$(bw get item $BW_ITEM_NAME | jq -r '.notes')"
echo "Item Retrieved"


for var in B2_ACCOUNT_ID B2_APPLICATION_KEY B2_CRYPT_PASSWORD B2_CRYPT_SALT; do
 if [[ -z "${!var:-}" ]]; then
   echo "Error: $var not set. Check Bitwarden item '$BW_ITEM_NAME'." >&2
   exit 1
 fi
 export "$var"
done


echo "generating config..."
envsubst < $HOME/.config/rclone/rclone.conf.template > $HOME/.config/rclone/rclone.conf
chmod 600 ~/.config/rclone/rclone.conf
echo "Locking BitWarden..."
bw lock
