FROM ccr.ccs.tencentyun.com/based-image/alpine:based

RUN apk add --no-cache freeradius freeradius-ldap && \
    chgrp radius  /usr/sbin/radiusd && chmod g+rwx /usr/sbin/radiusd

VOLUME ["/opt/db"]
VOLUME ["/etc/freeradius/certs"]

EXPOSE 1812/udp 1813/udp 18120

CMD ["radiusd","-xx","-f"]
