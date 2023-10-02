#!/bin/bash

# Epsium Script
# Copyright (c) 2023 Epsium-MegaCorp
# Licensed under the MIT License
# Website: https://epsium-invest.com/

folderprefix='.epsium_'
prefix='.epsium_'
directory_seperator='/'

# Find the number of folders with the desired prefix, including ".epsium" without a number
folder_count=$(ls -d ${folderprefix}* | wc -l)

if [ -d ".epsium" ]; then
    folder_count=$((folder_count + 1))
fi

if [ $folder_count -eq 0 ]; then
    echo "No matching folders found."
    exit 1
fi

for ((servernumber = 1; servernumber <= $folder_count; servernumber++)); do
    if [ $servernumber -eq 1 ]; then
        folder_name=".epsium"  # Handle the folder without a number
    else
        folder_name="${prefix}${servernumber}"  # Handle folders with numbers
    fi
    
    # Your code here for actions in each folder
    echo "Working in folder $folder_name"
    
    # Execute the stop command
    ./epsium-cli -datadir="/root/${folder_name}" -config="/root/${folder_name}/epsium.conf" stop
    
    # Check if the command was successful (0 means success)
    if [ $? -eq 0 ]; then
        echo "Folder $folder_name stopped successfully."
        
        # Add a sleep time (e.g., 10 seconds)
        sleep 10
        
        # Restart the folder
        ./epsiumd -datadir="/root/${folder_name}" -config="/root/${folder_name}/epsium.conf" &
        
        echo "Folder $folder_name restarted."
    else
        echo "Error stopping folder $folder_name."
    fi
done
