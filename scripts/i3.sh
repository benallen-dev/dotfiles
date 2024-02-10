fixmonitors() {
	xrandr --output HDMI-0 --off
	xrandr --output HDMI-0 --mode 1920x1080 --pos 0x0 --rotate left --output DP-4 --primary --mode 3440x1440 --pos 1080x0 --rotate normal
	feh --bg-fill /usr/share/sddm/themes/chili/assets/background.jpg
}

