# !/bin/bash
folderprefix='.epsium_'
prefix='.epsium_'
directory_seperator='/'

for servernumber in {1..13}
do

        blockCount=$(curl --silent 108.61.156.168:3001/api/getblockcount)
        blockHash=$(curl --silent 108.61.156.168:3001/api/getblockhash?index=$blockCount)
                echo "$servernumber"

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
echo "OK"
                echo "$servernumber"

        else
 sudo apt install unzip

                echo "$servernumber"
              ./epsium-cli -datadir=/root/.epsium_$servernumber -config=/root/.epsium_$servernumber/epsium.conf getmasternodestatus

        echo "falsch "

     ./epsium-cli -datadir=/root/.epsium_$servernumber -config=/root/.epsium_$servernumber/epsium.conf stop

        rm -r chainstate blocks peers.dat blocks/blk00000.dat
         wget https://github.com/Epsium-MegaCorp/Epsium-MegaCorp/releases/download/1.3.0.0/bootstrap.zip
         unzip  bootstrap.zip
         rm -r bootstrap.zip
         cd ..
         ./epsiumd -datadir=/root/.epsium_$servernumber -config=/root/.epsium_$servernumber/epsium.conf
       sleep 5
        fi
done
