FROM centos:latest
RUN dnf install git python openssh-server openssh-clients
CMD systemctl start sshd && systemctl status sshd
WORKDIR /usr/src/DBops
COPY . ./DBops
ENTRYPOINT ["python3", "service/server/run.py"]
EXPOSE 22
