FROM registry.fedoraproject.org/fedora-minimal:44

# set version label
ARG VERSION
ARG BUILD_VERSION
LABEL build_version="version:- ${VERSION} Build version: ${BUILD_VERSION}"
LABEL maintainer="ViReR"

EXPOSE 9117
VOLUME /var/lib/jackett
WORKDIR /opt/Jackett      

RUN dnf install curl sqlite3 libicu -y && dnf clean all 

USER root
RUN mkdir -p /var/lib/jackett && chown 1001:1001 /opt /var/lib/jackett/

USER 1001

ADD jackett.tar.gz /opt/

WORKDIR /opt/Jackett      

CMD [ "/opt/Jackett/Jackett", "-nobrowser", "-data=/var/lib/jackett/" ]

