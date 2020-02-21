FROM base_image
RUN yum update && yum install httpd httpd-tools -y
EXPOSE  80
EXPOSE  443
