#!/bin/bash

podman run --name syncthing  --network=host  -e STGUIADDRESS=  -v /data/syncthing:/var/syncthing:z docker.io/syncthing/syncthing:2.1.5

# EOF
