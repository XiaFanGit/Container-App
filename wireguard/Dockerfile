FROM daocloud.io/subaru/wireguard:based

COPY entrypoint.sh /entrypoint.sh
COPY wg0.conf.tpl /wg0.conf.tpl

RUN chmod +x /entrypoint.sh

CMD /run.sh
