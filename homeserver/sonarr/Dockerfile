FROM registry.fedoraproject.org/fedora-minimal:44

# set version label
ARG VERSION
ARG BUILD_VERSION
LABEL build_version="version:- ${VERSION} Build version: ${BUILD_VERSION}"
LABEL maintainer="ViReR"

EXPOSE 8989
VOLUME /var/lib/sonarr
WORKDIR /opt/Sonarr      

RUN dnf install curl sqlite3 libicu -y && dnf clean all 

USER root
RUN mkdir -p /var/lib/sonarr && chown 1001:1001 /opt /var/lib/sonarr/

USER 1001

ADD sonarr.tar.gz /opt/

WORKDIR /opt/Sonarr      

CMD [ "/opt/Sonarr/Sonarr", "-nobrowser", "-data=/var/lib/sonarr/" ]

