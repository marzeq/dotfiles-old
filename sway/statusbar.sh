while true
do
  DATE="$(date +'%Y-%m-%d %H:%M:%S')"
  VOLUME="$(pamixer --get-volume-human)"

  echo "墳 $VOLUME |   $DATE "
  sleep 1
done
