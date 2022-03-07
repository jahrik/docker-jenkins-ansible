FROM jenkins/jenkins:almalinux
LABEL maintainer="Wes Gill"

USER root
RUN yum -y update
RUN yum -y install epel-release
RUN yum -y install ansible

USER jenkins
