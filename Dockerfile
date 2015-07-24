FROM ubuntu:13.10
MAINTAINER developer  <developer@tanthing.com>

ENV JAVA_VERSION=7 \
    JAVA_UPDATE=65 \
    JAVA_BUILD=17 \
    JAVA_HOME=/usr/lib/jvm/java-7-oracle/ 

# update source  
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe"> /etc/apt/sources.list  
RUN apt-get update


# Install ssh
RUN apt-get install -y openssh-server
RUN mkdir -p /var/run/sshd


# Install curl  
RUN apt-get -y install curl

# Install JDK 7  
RUN cd /tmp &&  curl -L 'http://download.oracle.com/otn-pub/java/jdk/7u65-b17/jdk-7u65-linux-x64.tar.gz' -H 'Cookie: oraclelicense=accept-securebackup-cookie; gpw_e24=Dockerfile' | tar -xz  
RUN mkdir -p /usr/lib/jvm  
RUN mv /tmp/jdk1.7.0_65/ /usr/lib/jvm/java-7-oracle/

# Set Oracle JDK 7 as default Java  
RUN update-alternatives --install /usr/bin/java java /usr/lib/jvm/java-7-oracle/bin/java 300     
RUN update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/java-7-oracle/bin/javac 300     


EXPOSE 22
CMD ["/run.sh"]

ADD run.sh /run.sh
RUN chmod +x /*.sh



