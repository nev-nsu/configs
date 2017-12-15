#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

sudo echo "The privileges are available"

xrandr --output eDP-1 --mode 1366x768 --dpi 96
xrandr --output HDMI-1 --off

xfconf-query -c xfce4-panel -p /panels/panel-1/size -s "24"
xfconf-query -c xsettings -p /Xfce/LastCustomDPI -s "96"
xfconf-query -c xsettings -p /Xft/DPI -s "96"
xfconf-query -c displays -p /Default/eDP-1/Active -t bool -s 'true' 
xfconf-query -c displays -p /Default/eDP-1/Primary -t bool -s 'true' 
xfconf-query -c displays -p /Default/HDMI-1/Active -t bool -s 'false'
echo "Changing XFCE settings: done"

xfce-theme-manager -n -w xfce-simple-dark -c QtCurve -i gnome
echo "Changing theme: done"

$DIR/../ff_set.sh ~/.mozilla/firefox/ezq5jkvs.default layout.css.devPixelsPerPx 1
echo "Configuring Firefox: done"

echo "Preparing to reload XFCE..."
sleep 1
sudo systemctl restart lxdm

echo "Done."
