#!/bin/sh
echo "output|string|$(df -h / | awk 'NR==2 {print $4}')"
echo ""
