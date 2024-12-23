# #!/bin/bash

# # Variables
# REMOTE="mydrive:Obsidian"
# MOUNT_POINT="/home/lenovo/Documents/Obsidian"

# # Function to clean up (unmount) when stopping
# cleanup() {
#     echo "Stopping Obsidian and unmounting rclone..."
#     if pgrep obsidian > /dev/null; then
#         pkill obsidian
#         echo "Obsidian stopped."
#     fi
#     fusermount -u "$MOUNT_POINT" || umount "$MOUNT_POINT"
#     echo "Unmounted."
#     exit
# }

# # Create the mount point if it doesn't exist
# if [ ! -d "$MOUNT_POINT" ]; then
#     mkdir -p "$MOUNT_POINT"
# fi

# # Mount the Google Drive folder using rclone
# echo "Mounting Google Drive..."
# rclone mount "$REMOTE" "$MOUNT_POINT" --vfs-cache-mode writes &
# RCLONE_PID=$!

# # Launch Obsidian
# echo "Starting Obsidian..."
# obsidian &

# # Wait for the user to stop the process
# echo "Press Ctrl+C to stop Obsidian and unmount rclone."

# # Trap to handle cleanup when the user presses Ctrl+C
# trap cleanup SIGINT SIGTERM

# # Keep the script running in the foreground
# wait

# #!/bin/bash

# # Unmount the Rclone drive if it's already mounted
# if mountpoint -q /home/lenovo/Documents/Obsidian; then
#     echo "Unmounting existing Rclone mount..."
#     fusermount -u /home/lenovo/Documents/Obsidian
# fi

# # Kill any existing Rclone mount processes
# pkill -f "rclone mount mydrive:Obsidian"

# # Kill any running Obsidian instances
# pkill -f "flatpak run md.obsidian.Obsidian"

# # Mount Rclone drive
# echo "Mounting Rclone drive..."
# rclone mount mydrive:Obsidian /home/lenovo/Documents/Obsidian \
#     --vfs-cache-mode writes \
#     --config /home/lenovo/.config/rclone/rclone.conf &

# # Wait a moment to ensure the mount is ready
# sleep 5

# # Run Obsidian
# echo "Starting Obsidian..."
# flatpak run md.obsidian.Obsidian

# # Unmount the Rclone drive after Obsidian is closed
# echo "Unmounting Rclone drive..."
# fusermount -u /home/lenovo/Documents/Obsidian

# # Ensure the Rclone process is killed
# pkill -f "rclone mount mydrive:Obsidian"

# echo "Obsidian has been closed and Rclone drive unmounted."


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
    --config /home/lenovo/.config/rclone/rclone.conf \
    --allow-non-empty &

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
