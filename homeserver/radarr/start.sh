#!/bin/bash
###########
export VERSION=6.1.1.10360
export BUILD_VERSION=2
###########

podman run --name radarr --rm -d --network host -v /data/radarr:/var/lib/radarr:z -v /data/dl/:/data/dl/:z quay.io/$QUAY_USER/radarr:${VERSION}-${BUILD_VERSION}
# -p 7878:7878


# EOF
