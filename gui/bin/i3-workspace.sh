#!/bin/bash
# ~/bin/i3-workspaces.sh
i3-msg -t get_workspaces | jq -r '.[] | if .focused then "[" + .name + "]" else .name end' | tr '\n' ' '
