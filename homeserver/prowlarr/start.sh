#!/bin/bash

podman run --name prowlarr --rm -d --network host -v /data/prowlarr/:/var/lib/prowlarr/:z -v /data/dl/:/data/dl/:z quay.io/$QUAY_USER/prowlarr:2.4.0.5397-1 

# -p 9696:9696

# EOF
