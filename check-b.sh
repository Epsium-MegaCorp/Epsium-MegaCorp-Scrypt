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
        blockCount=$(curl --silent https://explorer.epsium-megacorp.com//api/getblockcount)
        blockHash=$(curl --silent https://explorer.epsium-megacorp.com//api/getblockhash?index=$blockCount)

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
            cd /root/$folder_name
            sudo rm -rf chainstate blocks peers.dat blocks/blk00000.dat
            sudo rm -rf blocks
            
            # Download and unzip bootstrap.zip
            wget https://github.com/Epsium-MegaCorp/Epsium-MegaCorp/releases/download/2.2.0/bootstrap.zip -P "/root/$folder_name"
            unzip "/root/$folder_name/bootstrap.zip" -d "/root/$folder_name"
            
            # Remove bootstrap.zip
            rm -f "/root/$folder_name/bootstrap.zip"
            cd ..

            # Start EPSIUM server
            ./epsiumd -datadir="/root/$folder_name" -config="/root/$folder_name/epsium.conf" &
            
            # Wait for the server to start
            sleep 5
            echo "Server started in folder $folder_name"
            # Add nodes using ./epsium-cli after the server is started
            ./epsium-cli -datadir="/root/$folder_name" -config="/root/$folder_name/epsium.conf" addnode "108.61.156.168" "onetry"
            ./epsium-cli -datadir="/root/$folder_name" -config="/root/$folder_name/epsium.conf" addnode "139.84.232.251" "onetry"
            ./epsium-cli -datadir="/root/$folder_name" -config="/root/$folder_name/epsium.conf" addnode "96.30.192.28" "onetry"
            ./epsium-cli -datadir="/root/$folder_name" -config="/root/$folder_name/epsium.conf" addnode "70.34.220.252" "onetry"
            ./epsium-cli -datadir="/root/$folder_name" -config="/root/$folder_name/epsium.conf" addnode "70.34.248.151" "onetry"
            ./epsium-cli -datadir="/root/$folder_name" -config="/root/$folder_name/epsium.conf" addnode "139.84.134.204" "onetry"
            ./epsium-cli -datadir="/root/$folder_name" -config="/root/$folder_name/epsium.conf" addnode "64.176.170.118" "onetry"
            ./epsium-cli -datadir="/root/$folder_name" -config="/root/$folder_name/epsium.conf" addnode "136.244.108.18" "onetry"
            ./epsium-cli -datadir="/root/$folder_name" -config="/root/$folder_name/epsium.conf" addnode "207.246.97.94" "onetry"
            ./epsium-cli -datadir="/root/$folder_name" -config="/root/$folder_name/epsium.conf" addnode "64.176.37.42" "onetry"
            ./epsium-cli -datadir="/root/$folder_name" -config="/root/$folder_name/epsium.conf" addnode "158.247.244.74" "onetry"
            ./epsium-cli -datadir="/root/$folder_name" -config="/root/$folder_name/epsium.conf" addnode "108.61.169.247" "onetry"
            ./epsium-cli -datadir="/root/$folder_name" -config="/root/$folder_name/epsium.conf" addnode "139.84.195.245" "onetry"
            
            sleep 5
        fi
    else
        echo "$folder_name does not exist."
    fi
done
