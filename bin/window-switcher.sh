#!/bin/bash
wmctrl -l | awk '{$1=$2=$3=""; print $0}' | sed 's/^ *//g' | tr -cd '[:print:]\n' | dmenu -i -l 20 | xargs -I {} wmctrl -a "{}"
