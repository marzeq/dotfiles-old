# Get available windows
WINDOWS=$(swaymsg -t get_tree | jq -r '.nodes[1].nodes[].nodes[] | .. | (.id|tostring) + " " + .name?' | grep -e "[0-9]* ."  )

# Select window with rofi
SELECTED=$(echo "$WINDOWS" | rofi -dmenu -i | awk '{print $1}')

# Tell sway to focus said window
swaymsg [con_id="$SELECTED"] focus
