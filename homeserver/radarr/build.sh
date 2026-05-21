#!/bin/bash 
###########
export VERSION=6.1.1.10360
export BUILD_VERSION=2
###########
set -v

wget --content-disposition 'http://radarr.servarr.com/v1/update/master/updatefile?os=linux&runtime=netcore&arch=x64'
mv Radarr*.linux*.tar.gz "radarr.tar.gz"

podman build -f Dockerfile --build-arg "VERSION=${VERSION}" --build-arg "BUILD_VERSION=${BUILD_VERSION}" -t radarr:${VERSION}-${BUILD_VERSION}


# podman tag localhost/radarr:${VERSION}-${BUILD_VERSION} quay.io/$QUAY_USER/radarr:${VERSION}-${BUILD_VERSION}
# podman push quay.io/rh-ee-scaps/radarr:${VERSION}-${BUILD_VERSION}

# EOF
