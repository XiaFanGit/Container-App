FROM debian:stretch-slim

ENV LANG="zh_CN.UTF-8" \
    LC_ALL="zh_CN.UTF-8" \
    LANGUAGE="zh_CN:zh" \
    TZ=Asia/Shanghai

RUN sed -i 's/security.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list && \
    sed -i 's/deb.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list && \
    apt-get update --yes && \
    apt-get upgrade --yes && \
    apt clean
