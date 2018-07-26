#!/bin/bash
#
# Build docker-container

dockerInstalled() {
    if ! [ -x "$(command -v docker)" ]; then
        echo 'Please install docker first, before running this project: https://www.docker.com/' >&2
        exit 1
    fi
}

dockerInstalled
cd libpuzzle-docker && docker build -t libpuzzle .

echo -e "BE SURE TO MANUALLY INSTALL: ffmpeg\n\n"

cat << EOF
    CentOS 7 Instructions:
    ------------------------------
    sudo yum install epel-release -y
    sudo rpm --import http://li.nux.ro/download/nux/RPM-GPG-KEY-nux.ro
    sudo rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm
    sudo yum install ffmpeg ffmpeg-devel -y


    Ubuntu Instructions:
    ------------------------------
    sudo add-apt-repository ppa:mc3man/trusty-media
    sudo apt-get update
    sudo apt-get dist-upgrade
    sudo apt-get install ffmpeg

EOF