FROM daocloud.io/subaru/wireguard:based

ENV INTERFACE_ADDR=10.20.100.1/24

COPY entrypoint.sh /entrypoint.sh
COPY add_client /add_client

RUN chmod +x /entrypoint.sh \
    && chmod +x /add_client

VOLUME ["/etc/wireguard"]

ENTRYPOINT ["/entrypoint.sh"]
