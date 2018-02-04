FROM jenkins/jenkins:2.89.3

ARG version=2.89.3

MAINTAINER Lenny Daume <lenny@reinvent.software>

USER root

RUN apt-get update \
	&& apt-get install -y sudo \
	vim \
	wget \
	curl \
	rsync \
	libltdl7 \
	jq \
	zip \
	&& rm -rf /var/lib/apt/lists/*

RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
RUN apt-get install -y nodejs

COPY ./mc /bin/mc

RUN chmod +x /bin/mc && \
			chmod 777 /bin/mc

USER jenkins

RUN sudo npm install -g newman

RUN curl -s "https://get.sdkman.io" | bash
