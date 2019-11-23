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
ENV IRSSI_VERSION 1.2.2
ENV FISH_VERSION 1.6

RUN git clone https://github.com/irssi/irssi \
	&& cd /irssi \
	&& git checkout tags/$IRSSI_VERSION \
	&& ./autogen.sh \
	&& make \
	&& make install

RUN git clone https://github.com/falsovsky/FiSH-irssi.git \
	&& cd /FiSH-irssi \
	&& git checkout tags/$FISH_VERSION \
	&& cmake . \
	&& make \
	&& make install
	
RUN git clone https://github.com/foretix/irssi-blowfish-docker.git \
	&& chmod +x /irssi-blowfish-docker/irssi_startup.sh

WORKDIR /irssi-blowfish-docker

ENTRYPOINT [ "bash", "irssi_startup.sh" ]
