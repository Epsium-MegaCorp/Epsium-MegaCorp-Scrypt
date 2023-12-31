#!/bin/bash

# Epsium Script
# Copyright (c) 2023 Epsium-MegaCorp
# Licensed under the MIT License
# Website: https://epsium-invest.com/

folderprefix='.epsium_'
prefix='.epsium_'
directory_seperator='/'

while true; do
    for servernumber in {1..13}
    do
        blockCount=$(curl --silent https://explorer2.epsium-invest.com/api/getblockcount)
        blockHash=$(curl --silent https://explorer2.epsium-invest.com/api/getblockhash?index=$blockCount)
        echo "$servernumber"
./epsium-cli -datadir=/root/.epsium_$servernumber -config=/root/.epsium_$servernumber/epsium.conf  addnode 96.30.192.28  onetry
./epsium-cli -datadir=/root/.epsium_$servernumber -config=/root/.epsium_$servernumber/epsium.conf  addnode 46.151.159.53:13726 onetry

sleep 2
        currentBlockCount=$(./epsium-cli -datadir=/root/.epsium_$servernumber -config=/root/.epsium_$servernumber/epsium.conf getblockcount)
        currentHash=$(./epsium-cli -datadir=/root/.epsium_$servernumber -config=/root/.epsium_$servernumber/epsium.conf getblockhash $currentBlockCount)

        echo $blockCount;
        echo $blockHash;
        echo $currentBlockCount;
        echo $currentHash;

        if [ $blockCount == $currentBlockCount ] && [ $blockHash == $currentHash ]; then

            echo "$servernumber"
            ./epsium-cli -datadir=/root/.epsium_$servernumber -config=/root/.epsium_$servernumber/epsium.conf getmasternodestatus
            ./epsium-cli -datadir=/root/.epsium_$servernumber -config=/root/.epsium_$servernumber/epsium.conf getbalance
            ./epsium-cli -datadir=/root/.epsium_$servernumber -config=/root/.epsium_$servernumber/epsium.conf addnode 176.10.123.171:5101 onetry
            echo "OK"
            echo "$servernumber"

        else
            sudo apt install unzip

            echo "$servernumber"
            ./epsium-cli -datadir=/root/.epsium_$servernumber -config=/root/.epsium_$servernumber/epsium.conf getmasternodestatus

            echo "falsch "

            ./epsium-cli -datadir=/root/.epsium_$servernumber -config=/root/.epsium_$servernumber/epsium.conf stop
         ./epsiumd -datadir=/root/.epsium_$servernumber -config=/root/.epsium_$servernumber/epsium.conf
             ./epsium-cli -datadir=/root/.epsium_$servernumber -config=/root/.epsium_$servernumber/epsium.conf addnode 96.30.192.28  onetry
            sleep 2
            ./epsium-cli -datadir=/root/.epsium_$servernumber -config=/root/.epsium_$servernumber/epsium.conf addnode  96.30.192.28 onetry
            ./epsium-cli -datadir=/root/.epsium_$servernumber -config=/root/.epsium_$servernumber/epsium.conf addnode 108.61.156.168 onetry

        fi
    done
    echo "5 Minuten Pause"
    sleep 300
done

