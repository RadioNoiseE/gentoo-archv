#!/usr/bin/env bash

ident_applic() { # allow identifying the window using both app_id and window_class;
                 # app_id is matched in a greedy way.
  local app_id="$1" window_class="$2"

  if [[ "$app_id" != "null" ]]; then
    echo "$app_id"
  elif [[ "$window_class" != "null" ]]; then
    echo "$window_class"
  else
    echo "null"
  fi
}

resize_applic() { # rules about the window of which app should be at which size;
                  # app_id is preferred to window_class, and the size should be <width>x<height>.
  local ident="$1" con_id="$2"

  declare -A app_sizes=(
    [foot]="1690x1060"
    [Emacs]="1690x1060"
  )

  local target_size=${app_sizes[$ident]}

  if [ -n "$target_size" ]; then
    local width=${target_size%x*}
    local height=${target_size#*x}
    swaymsg "[con_id=$con_id] resize set $width $height"
  fi
}

swaymsg -mt subscribe '["window"]' | jq --unbuffered -c 'select(.change == "new" or .change == "floating" ) | .container' | while read -r container; do # some rules to prevent activating can be specified;
                                                                                                                                                        # window type, role, title and class are supported.
  app_id=$(jq -r '.app_id' <<< "$container")
  window_class=$(jq -r '.window_properties.class' <<< "$container")

  con_id=$(jq -r '.id' <<< "$container")

  window_type=$(jq -r '.window_properties.type' <<< "$container")
  window_role=$(jq -r '.window_properties.role' <<< "$container")
  window_title=$(jq -r '.name' <<< "$container")

  roles=("pop-up" "bubble" "dialog" "task_dialog" "About")
  types=("menu" "notification" "dialog")
  titles=("Administrator privileges required" "About Mozilla Firefox")
  classes=("Pinentry" "pinentry")

  if [[ " ${roles[*]} " =~ " ${window_role} " ]] ||
     [[ " ${types[*]} " =~ " ${window_type} " ]] ||
     [[ " ${titles[*]} " =~ " ${window_title} " ]] ||
     [[ " ${classes[*]} " =~ " ${window_class} " ]] ||
     [[ $app_id == "floating" || $app_id == "floating_update" ]]; then
    continue
  fi

  app_ident=$(ident_applic "$app_id" "$window_class")

  resize_applic "$app_ident" "$con_id"
done
