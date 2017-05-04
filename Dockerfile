FROM centos
RUN mkdir -p /opt/kafka \
  && cd /opt/kafka \
  && echo '!!!!!!!!!kafka directory created' \
  && ln -s /var/run/secrets/rhel7.repo /etc/yum.repos.d/rhel7.repo \
  && echo '!!!!!!!!!soft link created' \
  && yum -y install java-1.8.0-openjdk-headless tar \
  && echo '!!!!!!!!!yum install java completed' \
  && curl -s http://www.mirrorservice.org/sites/ftp.apache.org/kafka/0.9.0.1/kafka_2.11-0.9.0.1.tgz | tar -xz --strip-components=1 \
  && echo '!!!!!!!!!CURL completed' \
  && yum -y remove tar \
  && echo '!!!!!!!!!YUM remove completed' \
  && yum clean all \
  && echo '!!!!!!!!!YUM clean all completed' \
  && rm /etc/yum.repos.d/rhel7.repo
COPY zookeeper-server-start-multiple.sh /opt/kafka/bin/
RUN chmod -R a=u /opt/kafka
WORKDIR /opt/kafka
VOLUME /tmp/kafka-logs /tmp/zookeeper
EXPOSE 2181 2888 3888 9092
