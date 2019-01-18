FROM ccr.ccs.tencentyun.com/based-image/alpine:based

ENV LDAP_SERVER = motofans.club \
    BIND_DN = cn=admin,dc=motofans,dc=club \
    PORT = 389 \
    PASSWORD = aaaaaaaaaa \
    BASE_DN = dc=motofans,dc=club

RUN apk add --no-cache freeradius freeradius-ldap && \
    chgrp radius  /usr/sbin/radiusd && chmod g+rwx /usr/sbin/radiusd && \
    rm /etc/raddb/mods-available/ldap

COPY mod.conf /etc/raddb/mods-available/ldap

VOLUME ["/opt/db"]
VOLUME ["/etc/freeradius/certs"]

EXPOSE 1812/udp 1813/udp 18120

ENTRYPOINT [ "/entrypoint.sh" ]