FROM ccr.ccs.tencentyun.com/based-image/alpine:based

RUN apk add --no-cache freeradius freeradius-ldap && \
    chgrp radius /usr/sbin/radiusd && \
    chmod g+rwx /usr/sbin/radiusd && \
    rm /etc/raddb/mods-available/ldap
    
COPY entrypoint.sh /entrypoint.sh
COPY ldap.conf /etc/raddb/mods-available/ldap

RUN chmod a+x /entrypoint.sh

EXPOSE 1812/udp 1813/udp 18120

ENTRYPOINT [ "/entrypoint.sh" ]
