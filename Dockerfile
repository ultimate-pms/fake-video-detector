FROM ubuntu:17.10

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -q && \
    apt-get install -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" \
        libgd2-dev libpuzzle-bin build-essential libtool m4 automake ffmpeg imagemagick

WORKDIR /opt/
ADD libpuzzle /opt/libpuzzle

RUN cd /opt/libpuzzle/ && \
    ./autogen.sh && \
    ./configure && \
    make && make install

ADD scripts /opt/scripts
ADD blacklist-originals /opt/blacklist-originals

CMD /opt/scripts/fake-video
#ENTRYPOINT puzzle-diff