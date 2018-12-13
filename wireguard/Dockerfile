FROM daocloud.io/subaru/wireguard:based

ENV INTERFACE_ADDR=10.20.100.1/24

COPY entrypoint.sh /entrypoint.sh
COPY add_client /add_client
COPY wg0.conf.tpl /wg0.conf.tpl

RUN chmod +x /entrypoint.sh \
    && chmod +x /add_client \
    && apk add --no-cache linux-headers

VOLUME ["/etc/wireguard"]

ENTRYPOINT ["/entrypoint.sh"]
