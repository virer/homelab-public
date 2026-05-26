FROM registry.fedoraproject.org/fedora-minimal:44

# set version label
ARG VERSION
ARG BUILD_VERSION
LABEL build_version="version:- ${VERSION} Build version: ${BUILD_VERSION}"
LABEL maintainer="ViReR"

EXPOSE 9117
WORKDIR /opt/Jackett      

RUN dnf install curl sqlite3 libicu -y && dnf clean all 

USER root
RUN chown 1001:1001 /opt

USER 1001

ADD jackett.tar.gz /opt/

WORKDIR /opt/Jackett      

CMD [ "/opt/Jackett/jackett", "--NoUpdates" ]

