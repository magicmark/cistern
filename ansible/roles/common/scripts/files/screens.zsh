#!/usr/bin/zsh

function _get_display_resolutions {
    xrandr --query | \
        sed "/^$1/,/connected/!d" | \
        head -n -1 | \
        sed '1d' | \
        tr -s ' ' | \
        cut -d ' ' -f 2
}

function _set_home_dell {
    if [ ! "$(_get_display_resolutions DP-1 | grep 2560x1440)" ]; then
        echo "Creating resolution for dell monitor"
        xrandr --newmode "2560x1440_60.00"  312.25  2560 2752 3024 3488  1440 1443 1448 1493 -hsync +vsync
        xrandr --addmode DP-1 2560x1440_60.00
    fi
}

function _set_work_monitor_right {
    if [ ! "$(_get_display_resolutions HDMI-2 | grep 1200x1920)" ]; then
        echo "Creating resolution for work monitor right"
        xrandr --newmode "1200x1920_59.90"  196.05  1200 1296 1424 1648  1920 1921 1924 1986  -HSync +Vsync
        xrandr --addmode HDMI-2 "1200x1920_59.90"
    fi
}

function _clear_other_screens {
    local other_screens

    other_screens=(
        "${(@f)$(xrandr | grep -E "^[a-zA-Z0-9-]+ (dis)?connected" | cut -d ' ' -f 1)}"
    )

    for screen in $other_screens; do
        echo "Turning $screen off"
        xrandr --output "$screen" --off
    done
}

function _set_scaled_output {
    local factor="$1"
    local width="$2"
    local height="$3"
    local xoffset="$4"

    integer scaled_width="$(($width*$factor))"
    integer scaled_height="$(($height*$factor))"
    echo "--mode ${width}x${height} --panning ${scaled_width}x${scaled_height}+${xoffset}+0 --scale ${factor}x$factor"
}

function _restart_i3 {
    i3-msg restart
    feh --bg-fill ~/backgrounds/fish.jpg
}

function screenset {

    #_clear_other_screens
    echo "\n"

    if [ "$1" == 'mbp@2x' ]; then

        echo "Setting display for MacBook Pro (MBP@2x)"
        xrandr \
            --output eDP-1 --mode 2880x1800 --dpi 180

    elif [ "$1" == 'dell' ]; then

        #_set_home_dell

        echo "Setting display for Dell U2713HM"
        eval "xrandr \
            --output DP-1 --dpi 180 --primary eDP-1 $(_set_scaled_output 1.8 2560 1440 0)"

    elif [ "$1" == 'samsung' ]; then
        echo "Setting display for MacBook Pro + Samsung"
        xrandr \
            --output eDP-1 --mode 2880x1800 --dpi 180 \
            --output HDMI-3 --mode 1920x1080 \
                --panning 3840x2160+2800+0 \
                --scale 2x2 --right-of eDP-1

    elif [ "$1" == 'dual' ]; then

        _set_work_monitor_right

        echo "Setting display for work (MBP - Monitor - Monitor Sideways)"
        eval "xrandr \
            --output eDP-1 --mode 2880x1800 --dpi 180 \
            --output HDMI-1 --dpi 180 --right-of eDP-1 $(_set_scaled_output 1.9 1920 1200 2880) \
            --output HDMI-2 --off"

    elif [ "$1" == 'work' ]; then
        _set_home_dell

        echo "Setting display for Dell ????"
        eval "xrandr \
            --output eDP-1 --mode 2880x1800 --dpi 180 \
            --output DP-1 --dpi 180 --right-of eDP-1 $(_set_scaled_output 1.7 2560 1440 2880)"


    elif [ "$1" == 'work2' ]; then

        echo "Setting display for HP ????"
        eval "xrandr \
            --output eDP-1 --mode 2880x1800 --dpi 180 \
            --output HDMI-1 --dpi 180 --right-of eDP-1 $(_set_scaled_output 1.8 1920 1200 2880)"


    elif [ "$1" == 'home' ]; then
        _set_home_dell

        echo "Setting display for Dell U2715H"
        eval "xrandr \
            --output eDP-1 --mode 2880x1800 --dpi 180 \
            --output DP-1 --dpi 180 --left-of eDP-1 $(_set_scaled_output 1.7 2560 1440 0)"
     fi

    _restart_i3
}
