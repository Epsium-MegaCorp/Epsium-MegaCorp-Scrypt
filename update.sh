#!/bin/bash

# Epsium Script
# Copyright (c) 2023 Epsium-MegaCorp
# Licensed under the MIT License
# Website: https://epsium-invest.com/

folderprefix='.epsium_'
prefix='.epsium_'
directory_seperator='/'
github_release_url='https://github.com/Epsium-MegaCorp/Epsium-MegaCorp/releases/download/1.3.0.0/linux-server.zip'

# Find the number of folders with the desired prefix, including ".epsium" without a number
folder_count=$(ls -d ${folderprefix}* | wc -l)

if [ -d ".epsium" ]; then
    folder_count=$((folder_count + 1))
fi

if [ $folder_count -eq 0 ]; then
    echo "No matching folders found."
    exit 1
fi

# Step 1: Stop all Epsium instances
for ((servernumber = 1; servernumber <= $folder_count; servernumber++)); do
    if [ $servernumber -eq 1 ]; then
        folder_name=".epsium"  # Handle the folder without a number
    else
        folder_name="${prefix}${servernumber}"  # Handle folders with numbers
    fi
    
    # Your code here for stopping each folder
    echo "Stopping folder $folder_name"
    
    # Execute the stop command
    ./epsium-cli -datadir="/root/${folder_name}" -config="/root/${folder_name}/epsium.conf" stop
    
    # Check if the command was successful (0 means success)
    if [ $? -eq 0 ]; then
        echo "Folder $folder_name stopped successfully."
    else
        echo "Error stopping folder $folder_name."
    fi
done

# Step 2: Wait for a brief moment
sleep 10

# Step 3: Remove specified files after stopping and starting
echo "Removing files: linux-server.zip, epsiumd, epsium-cli, epsium-tx"
rm -f linux-server.zip epsiumd epsium-cli epsium-tx

echo "Files removed."

# Step 4: Download the latest version from GitHub
echo "Downloading the latest version from GitHub"
wget "$github_release_url" -O linux-server.zip

if [ $? -eq 0 ]; then
    echo "Download successful."
else
    echo "Error downloading the latest version from GitHub."
    exit 1
fi

# Step 5: Extract the downloaded file to the root directory
echo "Extracting linux-server.zip to the root directory"
unzip -q linux-server.zip -d /

if [ $? -eq 0 ]; then
    echo "Extraction successful."
else
    echo "Error extracting linux-server.zip."
    exit 1
fi

# Step 6: Give execute permissions to epsiumd, epsium-cli, and epsium-tx
echo "Setting execute permissions for epsiumd, epsium-cli, and epsium-tx"
chmod +x /epsiumd /epsium-cli /epsium-tx

# Step 7: Start all Epsium instances
for ((servernumber = 1; servernumber <= $folder_count; servernumber++)); do
    if [ $servernumber -eq 1 ]; then
        folder_name=".epsium"  # Handle the folder without a number
    else
        folder_name="${prefix}${servernumber}"  # Handle folders with numbers
    fi
    
    # Your code here for starting each folder
    echo "Starting folder $folder_name"
    
    # Start the folder
    /epsiumd -datadir="/root/${folder_name}" -config="/root/${folder_name}/epsium.conf" &
    
    echo "Folder $folder_name started."
done
