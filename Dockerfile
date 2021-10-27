FROM docker.io/milkliver/ubi8-ubi
MAINTAINER milkliver
#ARG uid=0
#ARG gid=0
#USER 0

VOLUME /sys/fs/cgroup

RUN mkdir -p /opt/installPackage
RUN mkdir -p /opt/app-root/run
RUN mkdir -p /opt/app-root/src
RUN mkdir -p /opt/app-root/run/config

ADD ./install-package/ /opt/installPackage

RUN tar -xzvf /opt/installPackage/apache-maven-3.8.3-bin.tar.gz -C /opt/
RUN ln -s /opt/apache-maven-3.8.3/bin/mvn /usr/bin/mvn

RUN mv /opt/installPackage/run /opt/app-root/run/run
RUN mv /opt/installPackage/assemble /opt/app-root/run/assemble

RUN chown 1001:0 -R /opt/app-root
RUN chmod +x /opt/app-root/run/*

RUN yum install -y java-1.8.0-openjdk-devel
# RUN yum install -y curl
RUN yum clean all -y

WORKDIR /opt/app-root/run

RUN rm -rf /opt/installPackage
RUN rm -rf /tmp/*

CMD ["/opt/app-root/run/run"]
#CMD ["tail","-f","/dev/null"]
