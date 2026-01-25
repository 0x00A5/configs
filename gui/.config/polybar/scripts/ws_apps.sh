#!/usr/bin/env bash

declare -A ICONS=(
  ["librewolf"]=""
  ["alacritty"]=""
  ["thunar"]=""
  ["chromium"]=""
  ["slack"]=""
  ["obs"]=""
  ["obs-studio"]=""
  ["okular"]=""
  ["signal"]=""
)

current_ws=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true) | .name')
windows=$(i3-msg -t get_tree | jq -c --arg ws "$current_ws" '
  .. | objects
  | select(.type=="workspace" and .name==$ws)
  | .. | objects
  | select(.window != null)
  | {class: (.window_properties.class // ""), focused: .focused}
  | select(.class != "Polybar")
')
output=""

while read -r win; do
  win_class=$(jq -r '.class' <<<"$win")
  focused=$(jq -r '.focused' <<<"$win")

  win_class="${win_class,,}"
  [[ -z "$win_class" ]] && continue
	
  icon="${ICONS[$win_class]:-}"

  if [[ "$focused" == "true" ]]; then
    output+="%{B#585b70}%{F#b4befe} $icon %{B-}%{F-} "
  else
    output+="%{B#1e1e2e}%{F#b4befe} $icon %{B-}%{F-} "
  fi
done <<<"$windows"

echo "$output"

