#!/bin/bash

podman run -d --name=flaresolverr --net host -e LOG_LEVEL=info --restart unless-stopped ghcr.io/flaresolverr/flaresolverr:latest

# -p 8191:8191

# EOF
