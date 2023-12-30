#!/bin/bash
# Get the window id from the argument
window_id=$YABAI_WINDOW_ID

# Query Yabai for window information
window_info=$(/opt/homebrew/bin/yabai -m query --windows --window "$window_id")
# Extract the app, title, and whether the window is floating
app=$(echo "$window_info" | /opt/homebrew/bin/jq -r '.app')
layer=$(echo "$window_info" | /opt/homebrew/bin/jq -r '.layer')
is_floating=$(echo "$window_info" | /opt/homebrew/bin/jq -r '."is-floating"')
# Check if app is Arc, layer is normal, and window is floating - will leave it floating (yabaiwindow tag)
if [[ "$app" == "Arc" && "$layer" == "normal" && "$is_floating" == "true" ]]; then
    # Toggle float on the window
    /opt/homebrew/bin/yabai -m window "$window_id" --layer below
# Check if app is Arc, layer is above, and window is floating - will tile it (yabaitile tag)
elif [[ "$app" == "Arc" && "$layer" == "above" && "$is_floating" == "true" ]]; then
    sleep .3
    /opt/homebrew/bin/yabai -m window "$window_id" --toggle float --layer below
fi