FROM docker.io/jenkins/jenkins:almalinux
LABEL org.opencontainers.image.authors="jahrik@gmail.com"

USER root
# hadolint ignore=DL3033
RUN yum -y update \
  && yum -y install epel-release \
  && yum -y install ansible \
  && yum clean all

USER jenkins
