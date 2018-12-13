FROM daocloud.io/subaru/wireguard:based

ENV INTERFACE_ADDR=10.20.100.1/24

# Thanks for jessfraz's work:
# https://github.com/jessfraz/dockerfiles/blob/master/wireguard/install/Dockerfile
ENV WIREGUARD_VERSION 0.0.20181119

RUN set -x \
    && apk add --no-cache --virtual .build-deps \
    git \
    && git clone --depth 1 --branch "${WIREGUARD_VERSION}" https://git.zx2c4.com/WireGuard.git /wireguard \
    && ( \
        cd /wireguard/src \
        && make tools \
        && make -C tools install \
        && make -C tools clean \
	) \
    && apk del .build-deps

COPY entrypoint.sh /entrypoint.sh
COPY add_client /add_client
COPY wg0.conf.tpl /wg0.conf.tpl

RUN chmod +x /entrypoint.sh \
    && chmod +x /add_client \
    && apk add --no-cache linux-headers

VOLUME ["/etc/wireguard"]

ENTRYPOINT ["/entrypoint.sh"]
