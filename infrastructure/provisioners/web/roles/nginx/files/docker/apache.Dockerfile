FROM centos:latest
ENV container docker
RUN yum -y update && yum clean all
RUN yum install openssh-server -y
RUN mkdir .ssh
ADD resources/ssh_keys/ansible.pem.pub .ssh
RUN [ "chmod", "755", ".ssh/ansible.pem.pub" ]
RUN yum update && yum install httpd httpd-tools -y
EXPOSE  80
EXPOSE  443
EXPOSE 22
