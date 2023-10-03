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
    
    # Check if the folder exists
    if [ -d "/root/$folder_name" ]; then
        blockCount=$(curl --silent https://explorer2.epsium-invest.com/api/getblockcount)
        blockHash=$(curl --silent https://explorer2.epsium-invest.com/api/getblockhash?index=$blockCount)

        currentBlockCount=$(./epsium-cli -datadir="/root/$folder_name" -config="/root/$folder_name/epsium.conf" getblockcount)
        currentHash=$(./epsium-cli -datadir="/root/$folder_name" -config="/root/$folder_name/epsium.conf" getblockhash $currentBlockCount)

        echo $blockCount
        echo $blockHash
        echo $currentBlockCount
        echo $currentHash

        if [ $blockCount == $currentBlockCount ] && [ $blockHash == $currentHash ]; then
            echo "$servernumber"
            echo "OK"
        else
            echo "$servernumber"
            echo "False"
            ./epsium-cli -datadir="/root/$folder_name" -config="/root/$folder_name/epsium.conf" stop 
            
            # Remove chainstate, blocks, and peers.dat directories
            rm -rf "/root/$folder_name/chainstate" "/root/$folder_name/blocks" "/root/$folder_name/peers.dat"
            
            # Download and unzip bootstrap.zip
            wget https://github.com/Epsium-MegaCorp/Epsium-MegaCorp/releases/download/1.3.0.0/bootstrap.zip -P "/root/$folder_name"
            unzip "/root/$folder_name/bootstrap.zip" -d "/root/$folder_name"
            
            # Remove bootstrap.zip
            rm -f "/root/$folder_name/bootstrap.zip"
            
            ./epsiumd -datadir="/root/$folder_name" -config="/root/$folder_name/epsium.conf" &
            sleep 5
        fi
    else
        echo "$folder_name does not exist."
    fi
done
