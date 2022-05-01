VOLUME=$(seq 0 100 | rofi -dmenu)

if [[ ! -z "$VOLUME" ]]; then
  pamixer --set-volume $VOLUME
fi

