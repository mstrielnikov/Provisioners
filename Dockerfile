FROM centos:latest
ENV WORKDIR /ServerOps
ENV container docker
RUN yum -y update && yum clean all
RUN yum install git python3
RUN pip install python3-pip python3-distutils setuptools virtualenv \
    paramiko jinja2 python3-yaml ansible docker docker-compose ansible-container
WORKDIR /ServerOps
COPY . ./ServerOps
CMD python3 -m venv env
CMD source env/bin/activate
ENTRYPOINT ["python3", "manager/manager.py"]
