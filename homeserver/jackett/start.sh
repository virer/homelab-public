#!/bin/bash

podman run --name jackett -d -v /data/jackett:/opt/Jackett/.config:z --network host quay.io/rh-ee-scaps/jackett:0.24.2142-1

# -p 9117:9117

# EOF
