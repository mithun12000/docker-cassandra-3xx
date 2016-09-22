FROM centos:7

#maintainer
MAINTAINER "Mithun Mandal" <mithun12000@gmail.com>

#setting environment
ENV container docker

#install vim, wget and openjdk
RUN yum install -y vim wget java-1.8.0-openjdk && yum clean all

#change directory to home
RUN cd home

#Downloading JDK 7
RUN wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u101-b13/jdk-8u101-linux-x64.rpm" && yum localinstall jdk-8u101-linux-x64.rpm -y && yum clean all && rm -f jdk-8u101-linux-x64.rpm

#Install JDK
#RUN yum localinstall jdk-8u101-linux-x64.rpm -y

#removing local file
#RUN rm -f jdk-8u101-linux-x64.rpm

#Setting Java alternative
RUN alternatives --install /usr/bin/java java /usr/java/latest/bin/java 5
RUN alternatives --install /usr/bin/java java /usr/java/jdk1.8.0_101/bin/java 5
RUN alternatives --install /usr/bin/javac javac /usr/java/latest/bin/javac 5
RUN alternatives --install /usr/bin/javac javac /usr/java/jdk1.8.0_101/bin/javac 5
RUN alternatives --install /usr/bin/javaws javaws /usr/java/latest/bin/javaws 5
RUN alternatives --install /usr/bin/javaws javaws /usr/java/jdk1.8.0_101/bin/javaws 5
#RUN alternatives --set jar /usr/java/jdk1.7.0_79/bin/jar

RUN echo "JAVA_HOME=/usr/java/jdk1.8.0_101" > /etc/profile.d/java.sh
RUN echo "JRE_HOME=/usr/java/jdk1.8.0_101/jre" >> /etc/profile.d/java.sh
RUN echo "export JAVA_HOME" >> /etc/profile.d/java.sh
RUN echo "export JRE_HOME" >> /etc/profile.d/java.sh
RUN echo 'export PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin' >> /etc/profile.d/java.sh

RUN echo -e "[datastax]\nname = DataStax Repo for Apache Cassandra\nbaseurl = http://rpm.datastax.com/community\nenabled = 1\ngpgcheck = 0" >> /etc/yum.repos.d/datastax.repo

RUN yum install -y dsc30 cassandra30-tools && yum clean all

#set scala version
#RUN export SCALA_VERSION=scala-2.11.8
#RUN wget http://www.scala-lang.org/files/archive/scala-2.11.8.rpm
#RUN yum localinstall scala-2.11.8.rpm -y
#RUN rm -f scala-2.11.8.rpm

#RUN yum clean all