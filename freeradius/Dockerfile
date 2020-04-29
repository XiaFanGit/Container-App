FROM ccr.ccs.tencentyun.com/based-image/alpine:based

ENV LDAP_HOST = 'motofans.club' \
    LDAP_PORT = '389' \
    BASE_DN = 'dc=motofans,dc=club' \
    BIND_DN = 'cn=admin,dc=motofans,dc=club' \
    PASSWORD = 'BIND_DN_PASSWORD' \
    USERS_DN = 'ou=people,dc=motofans,dc=club' \
    GROUP_DN = 'ou=group,dc=motofans,dc=club' \
    RD_SHAREKEY = 'Subarutestkey'

RUN apk add --no-cache freeradius freeradius-ldap && \
    chgrp radius /usr/sbin/radiusd && \
    chmod g+rwx /usr/sbin/radiusd && \
    rm /etc/raddb/mods-available/ldap
    
COPY entrypoint.sh /entrypoint.sh
COPY ldap.conf /etc/raddb/mods-available/ldap

RUN chmod a+x /entrypoint.sh

EXPOSE 1812/udp 1813/udp 18120

ENTRYPOINT [ "/entrypoint.sh" ]
