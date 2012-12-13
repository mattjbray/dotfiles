xset +fp /usr/share/fonts/local
xset fp rehash
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
conky | while read -r; do xsetroot -name "$REPLY"; done &
exec dunst --geometry x1+0-0 &
while true
  do
  /usr/bin/dwm 2> /dev/null
done
