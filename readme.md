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

It works almost perfect. Like 99% accurate. 
Issues:
options that were in  [    ]  in the bash file are phrased <job><restart> without a space.

and

# change user nameservers
v-change-user-ns <user> <ns>1 <ns>2<ns>3<ns>4<ns>5<ns>6<ns>7<ns>8

it did not interpret this line right 
# options: USER NS1 NS2 [NS3] [NS4] [NS5] [NS6] [NS7] [NS8]

# update system ip
v-update-sys-ip <none>
# options: NONE
ive 
It needs to ignore the use of NONE

# archive directory
v-add-fs-archive <user> <archive> <source> <source>.
# options: USER ARCHIVE SOURCE [SOURCE...]

I think this is more a hestis cli script issue with...

I think if the last few things were fixed this would be a great help for the community
