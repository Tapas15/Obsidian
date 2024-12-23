#!/bin/bash

# Unmount the Rclone drive if it's already mounted
if mountpoint -q /home/lenovo/Documents/Obsidian; then
    echo "Unmounting existing Rclone mount..."
    fusermount -u /home/lenovo/Documents/Obsidian
fi

# Kill any existing Rclone mount processes
pkill -f "rclone mount mydrive:Obsidian"

# Kill any running Obsidian instances
pkill -f "flatpak run md.obsidian.Obsidian"

# Mount Rclone drive
echo "Mounting Rclone drive..."
rclone mount mydrive:Obsidian /home/lenovo/Documents/Obsidian \
    --vfs-cache-mode writes \
    --config /home/lenovo/.config/rclone/rclone.conf &

# Wait a moment to ensure the mount is ready
sleep 5

# Run Obsidian
echo "Starting Obsidian..."
flatpak run md.obsidian.Obsidian

# Unmount the Rclone drive after Obsidian is closed
echo "Unmounting Rclone drive..."
fusermount -u /home/lenovo/Documents/Obsidian

# Ensure the Rclone process is killed
pkill -f "rclone mount mydrive:Obsidian"

echo "Obsidian has been closed and Rclone drive unmounted."
