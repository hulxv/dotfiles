#!/bin/bash
REFRESH_TIME=0.05 # RFRESH 100 times per second
# Define your sound card number (might be different on your system)
CARD=0

# Define capture control name (check with `amixer -c $CARD controls`)
CAPTURE_CONTROL="Capture"  # Replace with actual capture control name

# Define mute indicator (might vary based on your system)
MUTE_INDICATOR="\[off\]"  # Look for "[off]" in the amixer output

function check_led_state {
  local mute_state=$(amixer -c $CARD sget $CAPTURE_CONTROL | grep "$MUTE_INDICATOR" -c)
  if [[ $mute_state -eq 0 ]]; then
    LED=0  # Mic Unmuted
  else
    LED=1  # Mic Muted
  fi
}
function set_led {
  local state=$1
  echo $state >> /sys/class/leds/platform::micmute/brightness  
}

while true; do 
    check_led_state 
    set_led $LED
    sleep $REFRESH_TIME  # Adjust check interval as needed
done
