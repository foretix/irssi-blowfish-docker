FROM debian:stretch-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
	ca-certificates \
	build-essential \
	libglib2.0-dev \
	libssl-dev \
	libdatetime-perl \
	libncurses-dev \
	libwww-perl \
	pkg-config \
	automake \
	dh-autoreconf \
	cmake \
	git \
	&& rm -rf /var/lib/apt/lists/*

ENV HOME /home/user
RUN useradd --create-home --home-dir $HOME user \
	&& mkdir -p $HOME/.irssi \
	&& chown -R user:user $HOME

ENV LANG C.UTF-8
ENV IRSSI_VERSION 1.2.0

RUN git clone https://github.com/irssi/irssi \
	&& cd /irssi \
	&& git checkout tags/$IRSSI_VERSION \
	&& ./autogen.sh \
	&& make \
	&& make install

RUN git clone https://github.com/falsovsky/FiSH-irssi.git \
	&& cd /FiSH-irssi \
	&& cmake . \
	&& make \
	&& make install

RUN printf "#!/bin/sh\nload fish\n./irssi" > $HOME/irssi_startup.sh \
	&& chmod +x $HOME/irssi_startup.sh

WORKDIR $HOME

ENTRYPOINT ["irssi_startup.sh"]
