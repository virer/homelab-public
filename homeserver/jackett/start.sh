#!/bin/bash

podman run --name jackett  -d --network host quay.io/rh-ee-scaps/jackett:0.24.1954-1

# -p 9117:9117

# EOF
