FROM jenkins/jenkins:2.89.3

ARG version=2.89.3

MAINTAINER Lenny Daume <lenny@reinvent.software>

USER root

#RUN echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list
#RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823

RUN apt-get update \
        && apt-get install -y sudo \
        vim \
        wget \
        curl \
        rsync \
        libltdl7 \
        jq \
        zip \
        apt-transport-https


RUN echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823

RUN     apt-get update && apt-get install -y sbt \
        && rm -rf /var/lib/apt/lists/*

RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
RUN apt-get install -y nodejs

COPY ./mc /bin/mc

RUN chmod +x /bin/mc && \
                        chmod 777 /bin/mc

#USER jenkins

RUN npm install -g newman

USER jenkins
