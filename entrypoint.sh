#!/bin/sh

/root/veins-veins-5.2/bin/veins_launchd -vv -c sumo &
cd /root/veins-veins-5.2/examples/veins
./run -u Cmdenv

