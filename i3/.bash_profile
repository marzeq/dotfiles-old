#
# ~/.bash_profile
#

if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
  exec startx i3
fi

[[ -f ~/.bashrc ]] && . ~/.bashrc
