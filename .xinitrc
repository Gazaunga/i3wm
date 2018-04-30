xrandr --output VGA-1 --mode 1920x1080
#setxkbmap -option ctrl:swapcaps &     # Swap Left Control and Caps Lock
xrdb -merge ~/.Xresources
urxvtd -q -o -f
#exec i3
exec dbus-launch "${1:-i3}"
