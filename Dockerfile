FROM debian:stretch-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
		ca-certificates \
		libdatetime-perl \
		libwww-perl \
		perl \
		wget \
    build-essential \
    irssi-dev \
    libglib2.0-dev \
    libssl-dev \
    cmake \
    git \
	&& rm -rf /var/lib/apt/lists/*

ENV HOME /home/user
RUN useradd --create-home --home-dir $HOME user \
	&& mkdir -p $HOME/.irssi \
	&& mkdir -p $HOME/.irssi/startup \
	&& chown -R user:user $HOME

ENV LANG C.UTF-8

ENV IRSSI_VERSION 1.2.0

RUN git clone https://github.com/falsovsky/FiSH-irssi.git \
	&& cd FiSH-irssi \
	&& cmake . \
	&& make \
	&& make install \
	&& echo "load fish" >> $HOME/.irssi/startup

WORKDIR $HOME

CMD ["irssi"]
