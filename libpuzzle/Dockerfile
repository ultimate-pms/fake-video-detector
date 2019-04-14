FROM ubuntu:17.10

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -q
RUN apt-get install -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" libgd2-dev libpuzzle-bin
RUN apt-get install -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" build-essential
RUN apt-get install -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" libtool m4 automake

RUN apt-get install imagemagick -y
ADD ./ /opt/libpuzzle/

WORKDIR /opt/libpuzzle/

RUN cd /opt/libpuzzle/ && \
    ./autogen.sh && \
    ./configure && \
    make && make install

#ENTRYPOINT puzzle-diff