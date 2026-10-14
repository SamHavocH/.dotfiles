#!/bin/bash
# Switch to / move a container to workspace number $1 on the CURRENTLY
# FOCUSED output, keeping each output's own independent 1..10 sequence.
# Distinct outputs get the same visible number by suffixing the workspace's
# internal name with zero-width spaces (invisible in bars), so "1" on eDP-1
# and "1" on DP-1 are different i3 workspaces that both display as "1".
#
# Usage: ws-per-output.sh <number> [move]

num="$1"
action="$2"

focused_output=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true) | .output')
mapfile -t outputs < <(i3-msg -t get_outputs | jq -r '[.[] | select(.active==true) | .name] | sort | .[]')

suffix=""
for o in "${outputs[@]}"; do
    [ "$o" = "$focused_output" ] && break
    suffix+=$'\u200b'
done

target="${num}${suffix}"

if [ "$action" = "move" ]; then
    i3-msg "move container to workspace \"$target\""
else
    i3-msg "workspace \"$target\""
fi
