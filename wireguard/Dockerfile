FROM daocloud.io/subaru/wireguard:based

ENV INTERFACE_ADDR=10.20.100.1/24

COPY entrypoint.sh /entrypoint.sh
COPY wg0.conf.tpl /wg0.conf.tpl

RUN chmod +x /entrypoint.sh

VOLUME ["/etc/wireguard"]

ENTRYPOINT ["/entrypoint.sh"]
