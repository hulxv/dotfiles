#!/bin/bash

if ! command -v yt-dlp &> /dev/null
then
    echo "yt-dlp could not be found. Please install it first."
    exit 1
fi

if ! command -v rofi &> /dev/null
then
    echo "rofi could not be found. Please install it first."
    exit 1
fi

VIDEO_URL=$(rofi -dmenu -p "Enter Video URL:" -theme ~/.config/rofi/colors/adapta.rasi)

if [ -z "$VIDEO_URL" ]; then
    echo "No URL entered. Exiting."
    exit 0
fi


if command -v ytd &> /dev/null; then
    ytd "$VIDEO_URL" &
fi

if command -v notify-send &> /dev/null; then
    notify-send "yt-dlp Download Started" "Downloading: $VIDEO_URL"
fi

echo "Download process started in the background. Check your terminal for progress or your Downloads folder."

exit 0
