#!/bin/bash
#
# Setup on local ubuntu machine without docker...

apt-get update -q
apt-get install imagemagick ffmpeg -y

apt-get install -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" libgd2-dev libpuzzle-bin
apt-get install -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" build-essential
apt-get install -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" libtool m4 automake

cd libpuzzle

./autogen.sh
./configure
make
make install