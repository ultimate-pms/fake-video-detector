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


if [ "$(cat ~/.zshrc | grep fake-video | wc -l)" -eq "0" ] && [ "$(cat ~/.bashrc | grep fake-video | wc -l)" -eq "0" ] ;then

    echo ">>>> Please specify the full path to your media directory"
    read -p 'Media Directory: ' MEDIA_DIR

    if [ -z $MEDIA_DIR ] ; then
        echo "<<<<<<<<<<<<<<<<<< You configure the 'Media Directory' to continue >>>>>>>>>>>>>>>>>>"
        exit 1
    fi

    echo -e "\nalias fake-video='docker run -it --rm --privileged -v \"$MEDIA_DIR:$MEDIA_DIR\" fake-video'" | tee -a ~/.bashrc ~/.zshrc
    echo -e "\nalias bulk-search='docker run -it --rm --privileged -v \"$MEDIA_DIR:$MEDIA_DIR\" bulk-search'" | tee -a ~/.bashrc ~/.zshrc
    
    source ~/.bashrc ~/.zshrc

else

    echo "System is already setup!"
    echo "Please remove the alias in your ~/.bashrc and ~/.zshrc files if you wish to re-run the setup process."

fi
