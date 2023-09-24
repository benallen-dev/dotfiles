#!/bin/sh
#
# NOTE: For this to work, you need to:
# - copy or symlink 99-wacom.rules to /etc/udev/rules.d/
# - copy or symlink wacom.service to /.config/systemd/user/
# - start the service with systemctl --user start wacom.service
# - enable the service with systemctl --user enable wacom.service
#
# Also note that this is really OS-specific so it isn't included in
# the install.sh script in the dotfiles root.

for i in $(seq 10); do
    if xsetwacom list devices | grep -q Wacom; then
        break
    fi
    sleep 1
done

list=$(xsetwacom list devices)
pad=$(echo "${list}" | awk '/pad/{print $9}')
stylus=$(echo "${list}" | awk '/stylus/{print $9}')
eraser=$(echo "${list}" | awk '/eraser/{print $9}')

if [ -z "${stylus}" ]; then
    exit 0
fi

# configure the buttons on ${stylus} with your xsetwacom commands...
xsetwacom set ${stylus} Button 2 "pan"
xsetwacom set ${stylus} "PanScrollThreshold" 150
xsetwacom set ${stylus} Rotate half
