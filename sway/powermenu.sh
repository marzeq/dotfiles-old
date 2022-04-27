#!/bin/bash

MODE=$(echo "suspend
reboot
poweroff" | rofi -dmenu)

if [[ ! -z "$MODE" ]]; then
  systemctl $MODE;
fi
