#!/bin/bash

# Epsium Script
# Copyright (c) 2023 Epsium-MegaCorp
# Licensed under the MIT License
# Website: https://epsium-invest.com/

# Number of folders to check
num_folders=20

# Create a file to store the copied information
output_file="copy.txt"
echo "" > "$output_file"

# Loop to copy the desired lines from the epsium.conf files
for ((i=1; i<=num_folders; i++)); do
    folder_name=".epsium_$i"
    conf_file_path="$folder_name/epsium.conf"

    if [ -f "$conf_file_path" ]; then
        externalip_line=$(grep "externalip=" "$conf_file_path")
        masternodeprivkey_line=$(grep "masternodeprivkey=" "$conf_file_path")
        rpcuser_line=$(grep "rpcuser=" "$conf_file_path")
        rpcpassword_line=$(grep "rpcpassword=" "$conf_file_path")
        rpcallowip_line=$(grep "rpcallowip=" "$conf_file_path")

        # Add a line with the folder number
        echo "Folder $i:" >> "$output_file"

        # Copy lines to the output file
        echo "$externalip_line" >> "$output_file"
        echo "$masternodeprivkey_line" >> "$output_file"
        echo "$rpcuser_line" >> "$output_file"
        echo "$rpcpassword_line" >> "$output_file"
        echo "$rpcallowip_line" >> "$output_file"

        echo "Folder '$folder_name': Lines copied."
    else
        echo "Folder '$folder_name': epsium.conf not found."
    fi
done

echo "Copied lines have been saved in '$output_file'."
