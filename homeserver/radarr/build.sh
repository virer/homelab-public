#!/bin/bash 
###########
export VERSION=6.1.1.10360
export BUILD_VERSION=1
###########
set -v
curl -L -o "radarr.tar.gz" "https://github.com/Radarr/Radarr/releases/download/v${VERSION}/Radarr.master.${VERSION}.linux-core-x64.tar.gz"

podman build -f Dockerfile --build-arg "VERSION=${VERSION}" --build-arg "BUILD_VERSION=${BUILD_VERSION}" -t radarr:${VERSION}-${BUILD_VERSION}

# EOF
