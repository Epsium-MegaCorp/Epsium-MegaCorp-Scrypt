  GNU nano 7.2                                gm.sh
#!/bin/bash

# Starte eine Endlosschleife
while true; do
    # Schleife von Server 1 bis 13
    for servernumber in {1..20}; do
        # Gib die aktuelle Servernummer aus
        echo "Servernummer: $servernumber"

        # Definiere das Datenverzeichnis und die Konfigurationsdatei für diesen Server
        data_dir="/root/.epsium_$servernumber"
        config_file="/root/.epsium_$servernumber/epsium.conf"

        # Führe den Befehl aus, um den Masternode-Status abzurufen
        ./epsium-cli -datadir="$data_dir" -config="$config_file" getmasternodestatus
        ./epsium-cli -datadir="$data_dir" -config="$config_file" getblockcount
./epsium-cli -datadir="$data_dir" -config="$config_file" clearbanned
./epsium-cli -datadir="$data_dir" -config="$config_file" addnode  108.61.156.168 onetry
./epsium-cli -datadir="$data_dir" -config="$config_file" addnode  108.61.156.168 onetry
./epsium-cli -datadir="$data_dir" -config="$config_file" addnode  70.34.248.151:4094 onetry
./epsium-cli -datadir="$data_dir" -config="$config_file" addnode  95.217.105.244:4094 onetry
./epsium-cli -datadir="$data_dir" -config="$config_file" addnode  139.84.232.251 onetry
./epsium-cli -datadir="$data_dir" -config="$config_file" addnode   66.42.58.77 onetry
./epsium-cli -datadir="$data_dir" -config="$config_file" addnode  95.217.105.244:4094 onetry
./epsium-cli -datadir="$data_dir" -config="$config_file" addnode  96.30.192.28 onetry

        # Gib erneut die aktuelle Servernummer aus
        echo "Servernummer: $servernumber"
#./epsium-cli -datadir="$data_dir" -config="$config_file" stop
#        ./epsiumd -datadir="$data_dir" -config="$config_file"
        # Warte 1 Sekunde, bevor zur nächsten Servernummer übergegangen wird
        sleep 1
    done
done

