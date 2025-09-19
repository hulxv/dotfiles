#!/bin/bash

# A script to select a process with rofi and kill it.

# Get a list of unique process names, sorted alphabetically.
# 'ps -e -o comm=' lists all process command names without headers.
# 'sort -u' sorts the list and removes duplicates.
chosen_process=$(ps -e -o comm= | sort -u | rofi -dmenu -i -p "Select process to kill")

# Exit if no process was selected (e.g., user pressed Esc).
if [[ -z "$chosen_process" ]]; then
    notify-send "Process Killer" "No process selected."
    exit 1
fi

# Get the Process ID(s) for the chosen process name.
# 'pidof' can return multiple PIDs if several instances are running.
pids=$(pidof "$chosen_process")

# Check if 'pidof' found any PIDs.
if [[ -z "$pids" ]]; then
    notify-send "Process Killer" "Could not find process: $chosen_process"
    exit 1
fi

# Loop through all found PIDs and kill each one.
# This ensures that if you have multiple windows of an application, all are killed.
for pid in $pids; do
    kill -9 "$pid"
    # Sending a desktop notification to confirm the action.
    notify-send "Process Killer" "Killed $chosen_process (PID: $pid)"
done

exit 0

