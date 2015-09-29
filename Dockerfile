FROM ubuntu

MAINTAINER Petter Helset <petter@helset.eu>

ENV RANCID_VERSION 3.2
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -q -y \
	expect \
	git \
	wget \
	build-essential \
	postfix \
	&& rm -rf /var/lib/apt/lists/*

RUN wget ftp://ftp.shrubbery.net/pub/rancid/rancid-$RANCID_VERSION.tar.gz -O- | tar zx
RUN cd /rancid-$RANCID_VERSION && ./configure --prefix=
RUN cd /rancid-$RANCID_VERSION && make && make install
RUN rm -rf rancid-$RANCID_VERSION

RUN adduser --disabled-password --gecos '' --home /var/lib/rancid rancid
RUN sed -e '14,15s/^#*/#/' -i /etc/rancid.conf
RUN sed -e 's/RCSSYS=cvs; export RCSSYS/RCSSYS=git; export RCSSYS/g' -i /etc/rancid.conf
RUN sed -e 's#BASEDIR=/var; export BASEDIR#BASEDIR=/var/lib/rancid; export BASEDIR#g' -i /etc/rancid.conf
RUN sed -e 's#CVSROOT=$BASEDIR/CVS; export CVSROOT#CVSROOT=$BASEDIR/var; export CVSROOT#g' -i /etc/rancid.conf

ADD run.sh /run.sh
CMD ["/run.sh"]
