FROM centos:latest
ENV WORKDIR /ServerOps
ENV container docker
RUN yum -y update && yum clean all
RUN yum install git python3 openssh-server openssh-clients -y
CMD systemctl start sshd && systemctl status sshd
WORKDIR /ServerOps
COPY . ./ServerOps
EXPOSE 22
ENTRYPOINT ["python3", "service/server/run.py"]
