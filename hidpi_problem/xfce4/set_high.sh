#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

sudo echo "The privileges are available"

xrandr --output HDMI-1 --mode 3840x2160 --dpi 162
xrandr --output eDP-1 --off

xfconf-query -c xsettings -p /Xfce/LastCustomDPI -s "162"
xfconf-query -c xsettings -p /Xft/DPI -s "162"
xfconf-query -c displays -p /Default/HDMI-1/Active -t bool -s 'true'
xfconf-query -c displays -p /Default/HDMI-1/Primary -t bool -s 'true' 
xfconf-query -c displays -p /Default/eDP-1/Active -t bool -s 'false' 
xfconf-query -c xfce4-panel -p /panels/panel-1/size -s "48"
echo "Changing XFCE settings: done"

xfce-theme-manager -n -w xfce4-hidpi-theme -c QtCurve -i gnome
echo "Changing theme: done"

$DIR/../ff_set.sh ~/.mozilla/firefox/ezq5jkvs.default layout.css.devPixelsPerPx 1.5
echo "Configuring Firefox: done"

echo "Preparing to reload XFCE..."
sleep 1
sudo systemctl restart lxdm

echo "Done."
