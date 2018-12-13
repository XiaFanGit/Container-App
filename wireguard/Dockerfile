FROM debian:latest

# Copy-Pasta from https://www.wireguard.com/install/
RUN echo "deb http://deb.debian.org/debian/ unstable main" > /etc/apt/sources.list.d/unstable-wireguard.list
RUN printf 'Package: *\nPin: release a=unstable\nPin-Priority: 150\n' > /etc/apt/preferences.d/limit-unstable
RUN apt update
RUN apt-get install -y wireguard-dkms wireguard-tools

#FROM daocloud.io/subaru/wireguard:based

#ENV INTERFACE_ADDR=10.20.100.1/24

#COPY entrypoint.sh /entrypoint.sh
#COPY add_client /add_client
#COPY wg0.conf.tpl /wg0.conf.tpl

#RUN chmod +x /entrypoint.sh \
#    && chmod +x /add_client \
#    && apk add --no-cache linux-headers

#VOLUME ["/etc/wireguard"]

#ENTRYPOINT ["/entrypoint.sh"]
