FROM daocloud.io/subaru/wireguard:based

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

VOLUME ["/etc/wireguard"]

ENTRYPOINT ["/usr/bin/wg"]
