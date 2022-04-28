#!/bin/bash

MODE=$(echo "suspend
logout
reboot
poweroff" | rofi -dmenu)

if [[ ! -z "$MODE" ]]; then
  if [ $MODE == "logout" ]; then
    swaymsg exit
  else
    systemctl $MODE
  fi
fi
