FROM daocloud.io/subaru/jumpserver:based

COPY entrypoint.sh /
COPY config.py /opt/jumpserver/config.py

RUN chmod +x /entrypoint.sh

VOLUME /opt/jumpserver/data

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]
