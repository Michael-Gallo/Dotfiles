#!/bin/sh

MINING_POOL="us1.ethermine.org"
PORT="4444"
CONFIG="A384"
# Needs $ETH_ADDRESS variable to be set 

sudo amdgpu-clocks
teamredminer -a ethash -o stratum+tcp://$MINING_POOL:$PORT  -u $ETH_ADDRESS --eth_config=$CONFIG
