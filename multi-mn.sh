#!/bin/bash

# Epsium Script
# Copyright (c) 2023 Epsium-MegaCorp
# Licensed under the MIT License
# Website: https://epsium-invest.com/
#ipv6
# Initial values for rpcport and port
initial_rpcport=4094
initial_port=5094

# Number of folders to create
num_folders=20  # You can change the number as needed

# Loop to create folders and add the epsium.conf file
for ((i=1; i<=num_folders; i++)); do
    folder_name=".epsium_$i"
    folder_path="$(pwd)/$folder_name"

    # Create the folder
    mkdir -p "$folder_path"

    # Generate random rpcuser and rpcpassword
    rpcuser=$(openssl rand -hex 16)
    rpcpassword=$(openssl rand -base64 16)

    # Incrementally increase rpcport and port
    rpcport=$((initial_rpcport + i))
    port=$((initial_port + i))

    # Ask the user for the server's IPv6 address
    read -p "Enter the IPv6 address for $folder_name: " server_ipv6

    # Get masternodeprivkey by running ./epsium-cli createmasternodekey
    masternodeprivkey=$(./epsium-cli createmasternodekey)

    # Create content for the epsium.conf file
    conf_content="rpcuser=$rpcuser
rpcpassword=$rpcpassword
rpcallowip=127.0.0.1
listen=1
server=1
daemon=1
staking=1
port=$port
rpcport=$rpcport
bind=[$server_ipv6]
maxconnections=64
masternode=1
externalip=[$server_ipv6]:4049
masternodeaddr=[$server_ipv6]:4094
masternodeprivkey=$masternodeprivkey
addnode=108.61.156.168
"

    # Save epsium.conf file in the folder
    conf_file_path="$folder_path/epsium.conf"
    echo -e "$conf_content" > "$conf_file_path"

    echo "Folder '$folder_name' created, and 'epsium.conf' added."
done
