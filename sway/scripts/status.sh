#!/bin/bash

get_volume() {
    volume_info=$(pactl get-sink-volume @DEFAULT_SINK@ | head -n 1)
    mute_info=$(pactl get-sink-mute @DEFAULT_SINK@)

    # Extract volume percentage
    volume=$(echo "$volume_info" | grep -Po '[0-9]+(?=%)' | head -1)

    # Check if muted
    if [[ "$mute_info" == *"yes"* ]]; then
        echo "Muted"
    else
        echo "Volume:${volume}%"
    fi
}

get_datetime() {
    date +'%Y-%m-%d %I:%M:%S %p'
}

get_cpu() {
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
    printf "CPU: %.1f%%" $cpu_usage
}

get_memory() {
    mem_info=$(free -m | awk 'NR==2{printf "%.1f%%", $3*100/$2}')
    echo "RAM: $mem_info"
}

get_plexamp() {
    # Check if Plexamp is running and has active media
    if playerctl -p Plexamp status &>/dev/null; then
        status=$(playerctl -p Plexamp status 2>/dev/null)
        
        if [ "$status" = "Playing" ]; then
            artist=$(playerctl -p Plexamp metadata artist 2>/dev/null)
            title=$(playerctl -p Plexamp metadata title 2>/dev/null)
            
            # Truncate long titles/artists
            if [ ${#title} -gt 30 ]; then
                title="${title:0:17}..."
            fi
            
            if [ ${#artist} -gt 20 ]; then
                artist="${artist:0:12}..."
            fi
            
            echo "$artist - $title"
        elif [ "$status" = "Paused" ]; then
            echo "Plexamp (Paused)"
        else
            echo "Plexamp (Stopped)"
        fi
    else
        echo ""  # Return empty if Plexamp isn't running
    fi
}

while true; do

    plexamp_info=$(get_plexamp)
    # Only add the plexamp info if it's non-empty
    if [ -n "$plexamp_info" ]; then
        status_line="$plexamp_info | "
    else
        status_line=""
    fi
    
    # Add your other status elements
    status_line="${status_line}$(get_cpu) | $(get_memory) | $(get_volume) | $(get_datetime)"
    echo "$status_line"
    sleep 1
done
