FROM ubuntu

MAINTAINER Petter Helset <petter@helset.eu>

ENV RANCID_VERSION 3.2
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
	&& apt-get install -q -y expect git wget build-essential \
	&& rm -rf /var/lib/apt/lists/*

RUN wget ftp://ftp.shrubbery.net/pub/rancid/rancid-$RANCID_VERSION.tar.gz -O- | tar zx
RUN cd /rancid-$RANCID_VERSION && ./configure
RUN cd /rancid-$RANCID_VERSION && make && make install
RUN rm -rf rancid-$RANCID_VERSION
