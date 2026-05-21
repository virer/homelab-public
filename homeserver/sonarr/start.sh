#!/bin/bash

podman run --name sonarr --rm -d --network host -v /data/sonarr:/var/lib/sonarr:z -v /data/dl/:/data/dl/:z quay.io/$QUAY_USER/sonarr:4.0.17.2952-2 

# -p 8989:8989

# EOF
