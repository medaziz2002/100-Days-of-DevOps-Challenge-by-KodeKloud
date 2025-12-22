#!/bin/bash

# Variables
SRC_DIR="/var/www/html/beta"
BACKUP_NAME="xfusioncorp_beta.zip"
LOCAL_BACKUP_DIR="/backup"
USER_NAME="clint"
SERVER_NAME="stbkp01"
REMOTE_BACKUP_DIR="/backup"

echo "Starting backup of ${SRC_DIR}..."

# Step A: create a zip archive of the source directory
if zip -r "${LOCAL_BACKUP_DIR}/${BACKUP_NAME}" "${SRC_DIR}"; then
    echo "Backup archive created successfully at ${LOCAL_BACKUP_DIR}/${BACKUP_NAME}"
else
    echo "Error creating backup archive. Exiting..."
    exit 1
fi

# Step B: copy the archive to the remote server
echo "Transferring backup to remote server ${SERVER_NAME}..."
if scp "${LOCAL_BACKUP_DIR}/${BACKUP_NAME}" "${USER_NAME}@${SERVER_NAME}:${REMOTE_BACKUP_DIR}"; then
    echo "Backup transfer completed successfully."
else
    echo "Error transferring backup to remote server. Exiting..."
    exit 1
fi
