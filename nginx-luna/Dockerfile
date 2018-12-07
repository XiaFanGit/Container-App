FROM alpine

RUN mkdir /opt

WORKDIR /opt

ENV luna_version 1.4.4

RUN apk add --no-cache wget nginx \
    && cd /opt \
    && wget https://github.com/jumpserver/luna/releases/download/${luna_version}/luna.tar.gz -O /opt/luna.tar.gz \
    && tar zxf luna.tar.gz \
    && chown -R root:root luna  \
    && rm -rf /opt/luna.tar.gz

EXPOSE 80

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
