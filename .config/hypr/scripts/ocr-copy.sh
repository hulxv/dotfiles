#!/bin/bash

# Temporary file for storing extracted text
text_filename=$(mktemp)

# Capture a selected region and extract text without saving a screenshot
case $1 in
    selected)
        grim -g "$(slurp)" - | tesseract stdin stdout > $text_filename 2>/dev/null
        ;;
    *)
        echo "Usage: $0 selected"
        exit 1
        ;;
esac

# Check if the text was extracted successfully
if [ -s $text_filename ]; then
    # Copy the extracted text to the clipboard
    cat $text_filename | wl-copy  # For Wayland
    # cat $text_filename | xclip -selection clipboard  # For X11, uncomment if using X11

    # Send a notification about the successful extraction
    notify-send -t 2500 "OCR Extraction" "Text extracted and copied to clipboard."
else
    notify-send "Text extraction failed."
fi

# Clean up temporary file
rm $text_filename
