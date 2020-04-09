FROM alpine:3.8

MAINTAINER Motofans

ENV LANG="zh_CN.UTF-8" \
	LANGUAGE="zh_CN:zh" \
	LC_ALL="zh_CN.UTF-8" \
	TZ=Asia/Shanghai \
	TERM=xterm

ARG VERSION="2.29-r0" \
	BASE_URL="https://github.com/sgerrand/alpine-pkg-glibc/releases/download" \
	ALPINE_GLIBC_BASE_PACKAGE_FILENAME="glibc-2.29-r0.apk" \
	ALPINE_GLIBC_BIN_PACKAGE_FILENAME="glibc-bin-2.29-r0.apk" \
	ALPINE_GLIBC_I18N_PACKAGE_FILENAME="glibc-i18n-2.29-r0.apk"

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && \
	apk update && \
	apk upgrade && \
	apk add --no-cache tzdata && \
	cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
	echo "Asia/Shanghai" > /etc/timezone && \
	rm -rf /tmp/* && \
	rm -rf /var/cache/apk/*

RUN apk add --no-cache --virtual=.build-dependencies wget ca-certificates && \
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    wget "$BASE_URL/$VERSION/$ALPINE_GLIBC_BASE_PACKAGE_FILENAME" \
         "$BASE_URL/$VERSION/$ALPINE_GLIBC_BIN_PACKAGE_FILENAME" \
         "$BASE_URL/$VERSION/$ALPINE_GLIBC_I18N_PACKAGE_FILENAME" && \
    apk add --no-cache "$ALPINE_GLIBC_BASE_PACKAGE_FILENAME" \
                       "$ALPINE_GLIBC_BIN_PACKAGE_FILENAME" \
                       "$ALPINE_GLIBC_I18N_PACKAGE_FILENAME" && \
    /usr/glibc-compat/bin/localedef -i en_US -f UTF-8 en_US.UTF-8 && \
    apk del .build-dependencies && \
    apk del glibc-i18n && \
    rm "/etc/apk/keys/sgerrand.rsa.pub" && \
    rm "/root/.wget-hsts" &&\
    rm  "$ALPINE_GLIBC_BASE_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_BIN_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_I18N_PACKAGE_FILENAME"
