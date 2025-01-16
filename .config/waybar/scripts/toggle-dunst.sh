#!/bin/bash

COUNT=$(dunstctl count waiting)
ENABLED=
DISABLED=
if [ $COUNT != 0 ]; then DISABLED=" $COUNT"; fi
if dunstctl is-paused | grep -q "false" ; then 
  echo "{\"text\":\"$ENABLED\", \"tooltip\":\"Notification Enabled\"}"; 
else 
  echo "{\"text\":\"$DISABLED\", \"tooltip\":\"Notification Muted\"}"; 
fi
