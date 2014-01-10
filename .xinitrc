#====[ Fonts ]====

  xset +fp /usr/share/fonts/local
  xset fp rehash

#====[ X ]====

  [[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
  [[ -s ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

#====[ Detect external monitor changes ]====

  IN="eDP1"
  EXT="HDMI1"

  while [ 1 ]; do
    if (xrandr | grep "$EXT disconnected"); then
      xrandr --output $IN --auto --output $EXT --off
    else
      xrandr --output $IN --auto --primary --output $EXT --auto --right-of $IN
    fi
    sleep 5
  done &

#====[ Status bar ]====

  conky | while read -r; do xsetroot -name "$REPLY"; done &

#====[ Notifications ]====

  dunst &

#====[ Sound ]====

  /usr/bin/start-pulseaudio-x11

#====[ Volume keys ]====

  xbindkeys

#====[ Window Manager ]====

  /usr/bin/dwm
