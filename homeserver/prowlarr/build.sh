#!/bin/bash 
###########
export VERSION=2.4.0.5397
export BUILD_VERSION=1
###########
set -vx


wget --content-disposition "https://github.com/Prowlarr/Prowlarr/releases/download/v${VERSION}/Prowlarr.master.${VERSION}.linux-core-x64.tar.gz"
mv Prowlarr*.linux*.tar.gz "prowlarr.tar.gz"

podman build -f Dockerfile --build-arg "VERSION=${VERSION}" --build-arg "BUILD_VERSION=${BUILD_VERSION}" -t prowlarr:${VERSION}-${BUILD_VERSION}


# EOF
