FROM alpine:edge

# ARG WG_VER

RUN echo "ipv6" >> /etc/modules
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk --no-cache add wireguard-tools bash iptables
