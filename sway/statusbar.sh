while true
do
  DATE="$(date +'%a %d/%m/%Y %H:%M:%S')"
  VOLUME="$(pamixer --get-volume-human)"
  VOLUMEVALUE=${VOLUME::-1}
  VOLUMEICON=""
  VOLUMETEXT="$VOLUME"

  if (( $VOLUMEVALUE == 0 )); then
    VOLUMETEXT="Muted"
    VOLUMEICON="婢"
  elif (( $VOLUMEVALUE >= 75)); then
    VOLUMEICON=""
  elif (( $VOLUMEVALUE >= 50 )); then
    VOLUMEICON="墳"
  elif (( $VOLUMEVALUE >= 25 )); then
    VOLUMEICON="奔"
  elif (( $VOLUMEVALUE < 25 )); then
    VOLUMEICON="奄"
  fi
  
  echo "$VOLUMEICON $VOLUMETEXT |   $DATE "
  sleep 0.1
done
