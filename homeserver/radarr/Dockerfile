FROM registry.fedoraproject.org/fedora:44

# set version label
ARG VERSION
ARG BUILD_VERSION
LABEL build_version="version:- ${VERSION} Build version: ${BUILD_VERSION}"
LABEL maintainer="ViReR"

EXPOSE 7878 
VOLUME /var/lib/radarr

RUN dnf install curl sqlite3 -y && dnf clean all 

USER root
RUN mkdir -p /opt/Radarr /var/lib/radarr && chown 1001:1001 /opt/Radarr /var/lib/radarr/

USER 1001
WORKDIR /opt/Radarr

ADD radarr.tar.gz .
# COPY radarr.tar.gz .
# RUN tar -vzxf radarr.tar.gz && rm -f radarr.tar.gz
RUN chmod a+x /opt/Radarr/Radarr && ls -l

CMD [ "/opt/Radarr/Radarr", "-nobrowser", "-data=/var/lib/radarr/" ]
