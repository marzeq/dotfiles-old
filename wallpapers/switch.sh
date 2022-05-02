a="/$0"; a=${a%/*}; a=${a#/}; a=${a:-.}
CURRENTDIR=$a
CURRENTDIR=$(readlink -f $CURRENTDIR)

CHOSEN=$(ls $CURRENTDIR -1 | sed -n "/\.png$/p" | sed "/wallpaper\.png/d" | sed "s/\.[^.]*$//" | rofi -dmenu)
unlink $CURRENTDIR/wallpaper.png
ln -s $CURRENTDIR/$CHOSEN.png $CURRENTDIR/wallpaper.png
swaymsg "output * bg $CURRENTDIR/$CHOSEN.png fill"

