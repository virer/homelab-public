FROM registry.fedoraproject.org/fedora-minimal:44

# set version label
ARG VERSION
ARG BUILD_VERSION
LABEL build_version="version:- ${VERSION} Build version: ${BUILD_VERSION}"
LABEL maintainer="ViReR"

EXPOSE 9696
VOLUME /var/lib/prowlarr
WORKDIR /opt/Prowlarr      

RUN dnf install curl sqlite3 libicu -y && dnf clean all 

USER root
RUN mkdir -p /var/lib/prowlarr && chown 1001:1001 /opt /var/lib/prowlarr/

USER 1001

ADD prowlarr.tar.gz /opt/

WORKDIR /opt/Prowlarr      

CMD [ "/opt/Prowlarr/Prowlarr", "-nobrowser", "-data=/var/lib/prowlarr/" ]

