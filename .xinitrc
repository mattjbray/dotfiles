conky | while read -r; do xsetroot -name "$REPLY"; done &
exec dunst --geometry x1+0-0 &
exec dwm
