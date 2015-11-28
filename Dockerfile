FROM ubuntu:14.04

ENV QPID_VERSION 0.32

RUN apt-get update -y -q
RUN apt-get install -y software-properties-common

RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update -y -q
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
RUN apt-get install -y -q oracle-java8-installer unzip xvfb libxrender1 libxtst6 libxi6 libgconf-2-4 curl openssh-server wget ssh curl

RUN wget http://apache-mirror.rbc.ru/pub/apache/qpid/0.32/binaries/qpid-broker-${QPID_VERSION}-bin.tar.gz -O /tmp/qpid.tar.gz && \
    tar xzf /tmp/qpid.tar.gz -C /opt && \
    ln -sf /opt/qpid-broker/${QPID_VERSION} /opt/qpid && \
    rm /tmp/qpid.tar.gz

CMD /opt/qpid/bin/qpid-server
