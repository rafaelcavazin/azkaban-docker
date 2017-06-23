FROM centos:7

RUN yum update -y && yum clean all
RUN yum -y install java

# set proper locales
RUN localedef -f UTF-8 -i en_US en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ADD ./azkaban-solo-server-0.1.0-SNAPSHOT azkaban
ADD run-azkaban.sh /
RUN chmod 777 run-azkaban.sh

ENTRYPOINT [ "/run-azkaban.sh"]
#ENTRYPOINT [ "/bin/sh",  "-c" ]
