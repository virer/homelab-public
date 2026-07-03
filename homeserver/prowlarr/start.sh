#!/bin/bash

podman run --name prowlarr --rm -d --network host -v /data/prowlarr:/opt/Prowlarr/.config:z -v /data/dl/:/data/dl/:z quay.io/$QUAY_USER/prowlarr:4.0.17.2952-2 

# -p 9696:9696

# EOF
