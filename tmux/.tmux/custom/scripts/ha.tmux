#!/usr/bin/env bash

get_entity_state() {
  local entity_id=$1
  res=$(curl -s -H "Authorization: Bearer $HA_TOKEN" -H 'content-type: application/json' "http://homeassistant.local:8123/api/states/${entity_id}"| jq -r '.state')
  echo $res
}

all_doors=$(get_entity_state "group.all_doors")

doors_interpolation="\#{all_doors}"

do_interpolation() {
  local output="$1"
  local output="${output/$doors_interpolation/$all_doors}"
  echo "$output"
}

update_tmux_uptime() {
  local option="$1"
  local option_value="$(get_tmux_option "$option")"
  local new_option_value="$(do_interpolation "$option_value")"
  set_tmux_option "$option" "$new_option_value"
}

main() {
  update_tmux_uptime "status-right"
  update_tmux_uptime "status-left"
}

main
