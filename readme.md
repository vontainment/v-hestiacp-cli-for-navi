![Header](./png_20230314_174753_0000.png)

# v-hestiacp-cli-for-navi
Here is code I working on that scans the hestia/bin dir and captures data and creates a hestiacp.cheat file formatted for navi (with variables for input options). It works almost perfect. Like 99% accurate. Issues: options that were in  [    ]  in the bash file are phrased <job><restart> without a space.

[https://github.com/denisidoro/navi][https://github.com/denisidoro/navi]

Here is code I working on that scans the hestia/bin dir and captures data and creates a hestiacp.cheat file formatted for navi (with variables for input options).

> #!/bin/bash
> cheat_file=~/hestiacp.cheat
> cd /usr/local/hestia/bin || exit
> echo "% HestiaCP" > "$cheat_file"
> for file in *; do
>     info=$(awk '/^# info:/ { sub("^# info: ", "", $0); print $0; }' "$file")
>     options=$(awk '/^# options:/ { sub("^# options: ", "", $0); print $0; }' "$file")
>     formatted_options=$(grep -oE '[^[][A-Z_]+[^]]' <<< "$options")
>     formatted_options=$(sed -E 's/([A-Z_]+)/<\L\1>/g' <<< "$formatted_options")
>     formatted_options=$(tr -s ' ' <<< "$formatted_options")
>     formatted_options=$(tr -d '\n' <<< "$formatted_options")
>     echo "# $info" >> "$cheat_file"
>     echo "$file $formatted_options" >> "$cheat_file"
>     echo >> "$cheat_file"
> done
