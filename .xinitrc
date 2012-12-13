xset +fp /usr/share/fonts/local
xset fp rehash
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
conky | while read -r; do xsetroot -name "$REPLY"; done &
exec dunst --geometry x1+0-0 &
exec dwm
