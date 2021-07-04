FROM ubuntu:20.04

# Normal Ubuntu build dependencies
#
# Executing 32-bit compiler binary on 64-bit architecture may
# result into "NO such file or directory" error because 32-bit
# loader does not exist. To fix this, we are enabling 32-bit
# architecture and install 32-bit binaries.
# https://askubuntu.com/questions/133389/no-such-file-or-directory-but-the-file-exists
RUN dpkg --add-architecture i386

ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update 

RUN apt-get install -y --no-install-recommends \
    gcc \
    git \
    wget \
    make \
    libncurses-dev \
    flex \
    bison \
    gperf \
    python3 \
    python3-serial \
    xxd \
    python3-pip \
    python3-setuptools \
    gawk \
    libc6:i386 \
    python3-libusb1

