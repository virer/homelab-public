#!/bin/bash 
###########
export VERSION=4.0.17.2952
export BUILD_VERSION=3
###########
set -v

wget --content-disposition 'https://services.sonarr.tv/v1/download/main/latest?version=4&os=linux&arch=x64'
mv Sonarr*.linux*.tar.gz "sonarr.tar.gz"

podman build -f Dockerfile --build-arg "VERSION=${VERSION}" --build-arg "BUILD_VERSION=${BUILD_VERSION}" -t sonarr:${VERSION}-${BUILD_VERSION}


# EOF
