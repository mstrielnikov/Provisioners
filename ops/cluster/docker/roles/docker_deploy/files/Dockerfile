FROM centos:latest
ENV container docker
RUN yum -y update && yum clean all
RUN mkdir .ssh
COPY ansible.pem.pub .ssh/ansible.pem.pub
RUN [ "chmod", "755", ".ssh/ansible.pem.pub" ]
EXPOSE 22
