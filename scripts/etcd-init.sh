#!/bin/bash
PUT="etcdctl put"
GET="etcdctl get"

# do not overwrite these values
initialized=$($GET initialized)
if [[ -n "$initialized" ]]; then
    echo "already initialized, aborting"
    exit 0
fi

# insert default values
$PUT '/config/default/retry' 20
$PUT '/config/default/wg_keepalive' 25
$PUT '/config/default/mtu' 1420
$PUT '/config/default/concentrators' '[{"address4": "172.16.0.1", "address6": "2001:bf7:380:1::1", "endpoint": "c1.net.freifunk-bs.de", "pubkey": "LfwcsPGyih7XpzUHCEaCpoJWP0JzYOFv9ElfItlgAiM="}, {"address4": "172.16.0.2", "address6": "2001:bf7:380:1::2", "endpoint": "c2.net.freifunk-bs.de", "pubkey": "whT6vlbUGSBKzKJGlxhevJf/PU/Jvdi9P6oSzAZ0i0E="}, {"address4": "172.16.0.3", "address6": "2001:bf7:380:1::3", "endpoint": "c3.net.freifunk-bs.de", "pubkey": "Xzzv10CknsICmteoJCGwHkERtVhS6xkT6LzPCrDxURM="}]'

# insert test client (num 0x3fff)
$PUT '/config/test/retry' 600
$PUT '/config/test/id' 16383
$PUT '/config/test/address4' '172.17.63.255'
$PUT '/config/test/range4' '10.255.252.0/22'
$PUT '/config/test/address6' '2001:bf7:381:3fff::1'
$PUT '/config/test/range6' '2001:bf7:381:3fff::/64'

$PUT 'initialized' "$(date)"
