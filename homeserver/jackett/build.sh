#!/bin/bash 
###########
export VERSION=0.24.2142
export BUILD_VERSION=1
###########
set -v

wget --content-disposition "https://github.com/Jackett/Jackett/releases/download/v${VERSION}/Jackett.Binaries.LinuxAMDx64.tar.gz"
mv Jackett*.Linux*.tar.gz "jackett.tar.gz"

podman build -f Dockerfile --build-arg "VERSION=${VERSION}" --build-arg "BUILD_VERSION=${BUILD_VERSION}" -t jackett:${VERSION}-${BUILD_VERSION}


# EOF
