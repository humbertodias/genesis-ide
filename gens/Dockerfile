FROM node:20-bookworm
# bash as default
SHELL ["/bin/bash", "-c"]
RUN apt update -y && apt install -y git cmake make sudo

ADD fn.sh /
RUN source /fn.sh \
    && install_emsdk latest

RUN source /opt/emsdk/emsdk_env.sh \
    && cd /opt \
    && git clone --recursive https://github.com/humbertodias/wasm-genplus.git \
    && cd wasm-genplus \
    && git reset HEAD --hard \
    && mkdir -p build && cd build \
    && emcmake cmake .. \
    && emmake make

WORKDIR /workdir
VOLUME /opt/wasm-genplus/docs/roms

ENV PORT=8081
EXPOSE 8081
CMD cd /opt/wasm-genplus \
    && npm install \
    && npm run start
