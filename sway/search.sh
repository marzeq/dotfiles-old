SEARCHENGINE="https://google.com/search?q="
QUERY=$(rofi -dmenu)

if [[ ! -z "$QUERY" ]]; then
  xdg-open "$SEARCHENGINE$QUERY"
fi
