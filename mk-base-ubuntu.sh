#!/bin/bash -e

if [ "$RELEASE" == "focal" ]; then
	RELEASE='focal'
elif [ "$RELEASE" == "buster" ]; then
	RELEASE='buster'
else
    echo -e "\033[36m please input the os type,stretch or buster...... \033[0m"
fi

if [ "$ARCH" == "armhf" ]; then
	ARCH='armhf'
elif [ "$ARCH" == "arm64" ]; then
	ARCH='arm64'
else
    echo -e "\033[36m please input the os type,armhf or arm64...... \033[0m"
fi

if [ ! $TARGET ]; then
	TARGET='gnome'
fi


if [ -e linaro-$RELEASE-alip-*.tar.gz ]; then
	rm linaro-$RELEASE-alip-*.tar.gz
elif [ -e ubuntu-$RELEASE-gnome-*.tar.gz ]; then
	rm ubuntu-$RELEASE-gnome-*.tar.gz
else
    echo -e "\033[36m please check the input os type...... \033[0m"
fi

cd ubuntu-build-service/$RELEASE-$TARGET-$ARCH

echo -e "\033[36m Staring Download...... \033[0m"

make clean

./configure

make

if [ -e linaro-$RELEASE-alip-*.tar.gz ]; then
	sudo chmod 0666 linaro-$RELEASE-alip-*.tar.gz
	mv linaro-$RELEASE-alip-*.tar.gz ../../
elif [ -e ubuntu-$RELEASE-gnome-*.tar.gz ]; then
	sudo chmod 0666 ubuntu-$RELEASE-gnome-*.tar.gz
	mv ubuntu-$RELEASE-gnome-*.tar.gz ../../
else
	echo -e "\e[31m Failed to run livebuild, please check your network connection. \e[0m"
fi
