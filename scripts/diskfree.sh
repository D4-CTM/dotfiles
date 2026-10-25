#!/bin/sh
avail() {
    if mountpoint -q "$1"; then
        df -h "$1" | awk 'NR==2 {print $4}'
    else
        echo "n/a"
    fi
}

echo "root|string|$(avail /)"
echo "games|string|$(avail /mnt/games)"
echo ""
