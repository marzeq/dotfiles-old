SEARCHENGINE="https://google.com/search?q="
QUERY=$(rofi -dmenu -p "Search the internet")

if [[ ! -z "$QUERY" ]]; then
  xdg-open "$SEARCHENGINE$QUERY"
fi
