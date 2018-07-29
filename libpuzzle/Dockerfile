FROM ubuntu:17.10

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -q
RUN apt-get install -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" libgd2-dev libpuzzle-bin
RUN apt-get install -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" build-essential
RUN apt-get install -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" libtool m4 automake

RUN apt-get install imagemagick -y
ADD ./ /root/

WORKDIR /root/

RUN ./autogen.sh
RUN ./configure
RUN make
RUN make install

#ENTRYPOINT puzzle-diff