#!/bin/sh

read -r used total <<EOF_VALS
$(free -b | awk 'NR==2 {printf "%.2f %.2f", $3/1073741824, $2/1073741824}')
EOF_VALS
echo "used|string|${used}"
echo "total|string|${total}"
echo ""
