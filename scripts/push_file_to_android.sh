#!/bin/bash

path="/sdcard/Download/adbpush/"

# Check if an argument was provided
if [ -z "$1" ]; then
  echo "Usage: $0 <file>"
  exit 1
fi

# Check if the file exists
if [ ! -f "$1" ]; then
  echo "Error: The file '$1' does not exist."
  exit 1
fi

# Execute the adb command to push the file
adb push "$1" "$path"

# Triger media store rescan
adb shell content call --method scan_volume --uri content://media --arg external_primary

# Check if the adb command was successful
if [ $? -eq 0 ]; then
  echo "File '$1' successfully pushed to $path"
else
  echo "Error: Failed to push the file '$1'. Ensure the device is connected and adb is properly configured."
  exit 1
fi

