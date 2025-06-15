#!/bin/bash

# === Configuration ===
DB_PATH="/home/pi/spoolman/data/spoolman.db"                   # Path to active Spoolman database
REPO_DIR="/home/pi/.local/share/spoolman"                      # Target Git repository
TARGET_DB="$REPO_DIR/spoolman.db"                              # Destination for copied DB

echo "=== BACKUP START ==="
echo "Time: $(date)"

# Log SHA256 checksums for transparency
echo "Source DB checksum:"
sha256sum "$DB_PATH"
echo "Target before copy checksum:"
sha256sum "$TARGET_DB"

# Copy the database to the Git repo
cp -f "$DB_PATH" "$TARGET_DB"

echo "Target after copy checksum:"
sha256sum "$TARGET_DB"

# Navigate to the Git repo and commit if changes are found
cd "$REPO_DIR" || exit

/usr/bin/git add spoolman.db

if ! /usr/bin/git diff --cached --quiet; then
    /usr/bin/git commit -m "Auto backup Spoolman DB $(date '+%Y-%m-%d %H:%M:%S')"
    /usr/bin/git push origin master
    echo "Backup committed and pushed to GitHub."
else
    echo "No changes to commit."
fi

echo "=== BACKUP END ==="
