#!/bin/sh

FILE=/tmp/magicmouse-driveload

reload() {
    if [ ! -f "$FILE" ]; then
        touch $FILE

        modprobe -r hid_magicmouse
        sleep 2
        modprobe hid_magicmouse \
           scroll_acceleration=1 \
           scroll_speed=25 \
           middle_click_3finger=1

        sleep 2
        rm -f "$FILE"

    fi
}

reload &