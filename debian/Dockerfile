FROM debian:stretch-slim

ENV TZ=Asia/Shanghai

RUN sed -i 's/security.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list && \
    sed -i 's/deb.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list && \
    apt-get update --yes && \
    apt-get upgrade --yes && \
    apt clean