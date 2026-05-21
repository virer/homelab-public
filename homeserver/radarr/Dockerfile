FROM registry.fedoraproject.org/fedora-minimal:44

# set version label
ARG VERSION
ARG BUILD_VERSION
LABEL build_version="version:- ${VERSION} Build version: ${BUILD_VERSION}"
LABEL maintainer="ViReR"

EXPOSE 7878 
VOLUME /var/lib/radarr
WORKDIR /opt/Radarr      

RUN dnf install curl sqlite3 libicu -y && dnf clean all 

USER root
RUN mkdir -p /var/lib/radarr && chown 1001:1001 /opt /var/lib/radarr/

USER 1001

ADD radarr.tar.gz /opt/
# COPY radarr.tar.gz /opt/
# RUN tar -vzxf radarr.tar.gz && rm -f radarr.tar.gz

WORKDIR /opt/Radarr      

CMD [ "/opt/Radarr/Radarr", "-nobrowser", "-data=/var/lib/radarr/" ]
