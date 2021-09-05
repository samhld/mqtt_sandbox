#!/bin/bash
set -x

docker build ./client -t python-mqtt-client

number=5
interval=1
format=value

while getopts ":n:i:f:" opt; do
    case ${opt} in 
        n ) number=$OPTARG
        ;;
        i ) interval=$OPTARG
        ;;
        f ) format=$OPTARG
        ;;
    esac
done

echo ${number}
echo ${interval}

for ((i=0; i<number; i++)); do
    docker run -d --rm --network mqtt-demo_default --name py-mqtt-client${i} python-mqtt-client /mqtt_client.py --interval ${interval} --format ${format}
done