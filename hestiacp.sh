#!/bin/bash
##############################################
#  Project: Hestia Cheats                    #
#  Author: Vontainment                       #
#  URL: https://vontainment.com              #
#  Description: Navi Chat Maker For HestiaCP #
##############################################

cheat_file=~/hestiacp.cheat
cd /usr/local/hestia/bin || exit
echo "% HestiaCP" > "$cheat_file"
for file in *; do
    info=$(awk '/^# info:/ { sub("^# info: ", "", $0); print $0; }' "$file")
    options=$(awk '/^# options:/ { sub("^# options: ", "", $0); print $0; }' "$file")
    formatted_options=$(grep -oE '[^[][A-Z_]+[^]]' <<< "$options")
    formatted_options=$(sed -E 's/([A-Z_]+)/<\L\1>/g' <<< "$formatted_options")
    formatted_options=$(tr -s ' ' <<< "$formatted_options")
    formatted_options=$(tr -d '\n' <<< "$formatted_options")
    echo "# $info" >> "$cheat_file"
    echo "$file $formatted_options" >> "$cheat_file"
    echo >> "$cheat_file"
done
