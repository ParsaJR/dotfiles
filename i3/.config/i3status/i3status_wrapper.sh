#!/usr/bin/env bash

# This i3status wrapper allows to add custom information in any position of the statusline

# This i3status wrapper allows to add custom information in any position of the statusline
# It was developed for i3bar (JSON format)

# The idea is to define "holder" modules in i3status config and then replace them

# In order to make this example work you need to add
# order += "tztime holder__hey_man"
# and
# tztime holder__hey_man {
#        format = "holder__hey_man"
# }
# in i3staus config

# Don't forget that i3status config should contain:
# general {
#   output_format = i3bar
# }
#
# and i3 config should contain:
# bar {
#   status_command exec /path/to/this/script.sh
# }

# Make sure jq is installed
# That's it

# You can easily add multiple custom modules using additional "holders"

function update_holder {
	# the parameter that has to be replaced.
	local instance="$1"
	# the replacement text
	local replacement="$2"
	echo "$json_array" | jq --argjson arg_j "$replacement" "(.[] | (select(.instance==\"$instance\"))) |= \$arg_j"
}

function cputemp {
	local cputemp=$(sensors | grep "Package id 0:" | awk '{ gsub("+",""); {print $4}}')
	local json='{"full_text": "'$cputemp'", "color": "#FFA500"}'
	json_array=$(update_holder holder_cputemp "$json")
}

function uptimefunc {
	local uptimetxt=$(echo -n "Uptime: " && uptime -p | awk '{print $2,$3}')
	local json='{"full_text": "'$uptimetxt'", "color": "#ffffff"}'
	json_array=$(update_holder holder_uptime "$json")
}

i3status | (
	read line
	echo "$line"
	read line
	echo "$line"
	read line
	echo "$line"
	while true; do
		read line
		json_array="$(echo $line | sed -e 's/^,//')"
		cputemp
		uptimefunc
		echo ",$json_array"
	done
)
