#
# ~/.bash_profile
#
export GTK_THEME="Adwaita-One-Dark"
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_DESKTOP=sway
export XDG_CURRENT_SESSION_TYPE=wayland
export GDK_BACKEND="wayland,x11"
export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORMTHEME=qt5ct
export XDG_DATA_DIRS="/var/lib/flatpak/exports/share/applications:$XDG_DATA_DIRS"

if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
  exec sway
fi
