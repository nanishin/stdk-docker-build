FROM stdk_common_env:latest

RUN cd /usr/bin/ && \
    ln -sf python3 python

# Refer latest toolchain version in https://docs.espressif.com/projects/esp-idf/en/latest/esp32/api-guides/tools/idf-tools.html
#ADD xtensa-esp32-elf-gcc8_4_0-esp-2021r1-linux-amd64.tar.gz /root/esp/

RUN git clone https://github.com/SmartThingsCommunity/st-device-sdk-c-ref.git

RUN echo 'export PATH='${PATH}':/root/esp/xtensa-esp32-elf/bin' >> /root/.profile
RUN echo 'export IDF_PATH=/st-device-sdk-c-ref/bsp/esp32' >> /root/.profile
RUN echo 'export SHELL=/bin/bash' >> /root/.profile
RUN echo 'export GIT_DISCOVERY_ACROSS_FILESYSTEM=1' >> /root/.profile

WORKDIR /st-device-sdk-c-ref

RUN python setup.py esp32

RUN /st-device-sdk-c-ref/bsp/esp32/install.sh
#RUN . /st-device-sdk-c-ref/bsp/esp32/export.sh

RUN pip3 install pynacl pyserial qrcode

#RUN cd /st-device-sdk-c-ref/iot-core/tools/keygen/ && \
#    python3 ./stdk-keygen.py --mnid YOUR_MNID --firmware YOUR_VERSION

#To use build.py properly, root profile should be sourced in advance.
#. ~/.profile
