xrdb merge ~/.Xresources
xrandr && xrandr --output Virtual1 --mode 2880x1800 --dpi 180
xsetroot -solid "#3E5059"
feh --bg-fill ~/backgrounds/fish.jpg
xcalib ~/colorprofiles/Color\ LCD-F466F621-B5FA-04A0-0800-CFA6C258DECD.icc
#echo 'on' > '/sys/bus/usb/devices/1-5/power/control';
#echo 'on' > '/sys/bus/usb/devices/1-8/power/control';

exec i3

# Start a D-Bus session
source /etc/X11/xinit/xinitrc.d/30-dbus
# Start GNOME Keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
# You probably need to do this too:
export SSH_AUTH_SOCK
export GPG_AGENT_INFO
export GNOME_KEYRING_CONTROL
export GNOME_KEYRING_PID`

dunst -config /home/markl/.config/dunst/dunstrc &

true
