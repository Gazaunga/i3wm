xrandr --output VGA-1 --mode 1920x1080
xsetroot -cursor_name left_ptr
xset +fp ./.fonts/bitmap/
xset fp rehash
xset s off
xset -dpms
xset r rate 200 60
xmodmap -e 'clear Lock' #ensures you're not stuck in CAPS on mode
xmodmap -e 'keycode 0x42=Escape' #remaps the keyboard so CAPS LOCK=ESC
xrdb merge ./.Xresources
urxvtd -q -o -f
#exec dbus-launch "${1:-i3}"
exec dbus-launch --exit-with-session i3
