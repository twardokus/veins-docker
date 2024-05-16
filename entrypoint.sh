#!/bin/sh

/root/veins-veins-5.2/bin/veins_launchd -vv -c sumo &
cd /root/veins-veins-5.2/examples/veins
./run -u Cmdenv
opp_scavetool x results/General-\#0.sca -F JSON -o results/General-\#0.json
cp -r ./results /root/veins-results/$(date +'%Y%m%d-%H%M%S%Z')
