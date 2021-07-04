#!/bin/sh

CURRENT_ESP32_TOOLCHAIN=xtensa-esp32-elf-gcc8_4_0-esp-2021r1-linux-amd64.tar.gz
CHECK_ESP32_TOOLCHAIN=`ls $CURRENT_ESP32_TOOLCHAIN`
if [ -z $CHECK_ESP32_TOOLCHAIN ]
then
    wget https://github.com/espressif/crosstool-NG/releases/download/esp-2021r1/xtensa-esp32-elf-gcc8_4_0-esp-2021r1-linux-amd64.tar.gz
fi

STDK_ENV_DOCKERFILE=stdk-common-env.dockerfile
STDK_ENV_IMAGE=stdk_common_env
STDK_CHIPSET=esp32
STDK_DEV_DOCKERFILE=stdk-${STDK_CHIPSET}-dev.dockerfile
STDK_DEV_IMAGE=stdk_${STDK_CHIPSET}_dev

# 1. Check docker env image for stdk common environment
CHECK_BASE_IMAGE=`docker images | awk '{print $1}' | grep $STDK_ENV_IMAGE`
if [ -z $CHECK_BASE_IMAGE ]
then
    docker build --rm -t $STDK_ENV_IMAGE -f $STDK_ENV_DOCKERFILE .
else
    echo "Found docker image - $CHECK_BASE_IMAGE. So skip to build env image"
fi

# 2. Check docker dev image for stdk development
CHECK_DEV_IMAGE=`docker images | awk '{print $1}' | grep $STDK_DEV_IMAGE`
if [ -z $CHECK_DEV_IMAGE ]
then
    docker build --rm -t $STDK_DEV_IMAGE -f $STDK_DEV_DOCKERFILE .
else
    echo "Found docker image - $CHECK_DEV_IMAGE. So skip to build dev image"
fi

