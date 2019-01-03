FROM alpine

ENV LANG="en_US.UTF-8" \
    LANGUAGE="en_US:en" \
    LC_ALL="en_US.UTF-8" \
    BASE_URL="https://github.com/sgerrand/alpine-pkg-glibc/releases/download" \
    VERSION="2.28-r0" \
    ALPINE_GLIBC_BASE_PACKAGE_FILENAME="glibc-2.28-r0.apk" \
    ALPINE_GLIBC_BIN_PACKAGE_FILENAME="glibc-bin-2.28-r0.apk" \
    ALPINE_GLIBC_I18N_PACKAGE_FILENAME="glibc-i18n-2.28-r0.apk"

RUN apk add --no-cache --virtual=.build-dependencies wget ca-certificates && \
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    wget "$BASE_URL/$VERSION/$ALPINE_GLIBC_BASE_PACKAGE_FILENAME" \
         "$BASE_URL/$VERSION/$ALPINE_GLIBC_BIN_PACKAGE_FILENAME" \
         "$BASE_URL/$VERSION/$ALPINE_GLIBC_I18N_PACKAGE_FILENAME"
         
    #apk add --no-cache "$ALPINE_GLIBC_BASE_PACKAGE_FILENAME" && \
    #                   "$ALPINE_GLIBC_BIN_PACKAGE_FILENAME" && \
    #                   "$ALPINE_GLIBC_I18N_PACKAGE_FILENAME" \
        
    #/usr/glibc-compat/bin/localedef -i en_US -f UTF-8 en_US.UTF-8 \
    
    #apk del .build-dependencies \
    #apk del glibc-i18n \
    #rm "/etc/apk/keys/sgerrand.rsa.pub" \
    #rm "/root/.wget-hsts" \
    #rm  "$ALPINE_GLIBC_BASE_PACKAGE_FILENAME" && \
    #    "$ALPINE_GLIBC_BIN_PACKAGE_FILENAME" && \
    #    "$ALPINE_GLIBC_I18N_PACKAGE_FILENAME"
