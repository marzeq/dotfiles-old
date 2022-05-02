#
# ~/.bash_profile
#

if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
  export GTK_THEME="Adwaita-One-Dark"
  export XDG_CURRENT_DESKTOP=sway
  export XDG_SESSION_DESKTOP=sway
  export XDG_CURRENT_SESSION_TYPE=wayland
  export GDK_BACKEND="waland,x11"
  export QT_QPA_PLATFORM=wayland
  export QT_QPA_PLATFORMTHEME=qt5ct
  exec sway
fi

[[ -f ~/.bashrc ]] && . ~/.bashrc
. "$HOME/.cargo/env"
