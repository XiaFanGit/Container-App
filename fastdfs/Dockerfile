FROM debian:stretch-slim

ENV TRACKER_PATH=/home/fastdfs/tracker \
    STORAGE_PATH=/home/fastdfs/storage \
    SRC_DIR=/home/workdir

WORKDIR /home/workdir

RUN sed -i 's/security.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list \
    && sed -i 's/deb.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list \
    && apt-get update --yes \
    && mkdir -p ${TRACKER_PATH} \
    && mkdir -p ${STORAGE_PATH} \
    && apt-get install --yes --no-install-recommends libpcre3 libpcre3-dev openssl libssl-dev libperl-dev zlib1g zlib1g-dev \
    && apt-get install --yes --no-install-recommends build-essential wget git ca-certificates supervisor \
    && git clone --branch V1.0.7 --depth 1 https://github.com/happyfish100/libfastcommon.git \
    && git clone --branch V5.05 --depth 1 https://github.com/happyfish100/fastdfs.git \
    && wget http://nginx.org/download/nginx-1.6.3.tar.gz \
    && wget http://192.168.173.115:8090/fastdfs-nginx-module.tar.gz \
    && wget http://192.168.173.115:8090/ngx_cache_purge-2.3.tar.gz \
    && tar -xvf nginx-1.6.3.tar.gz \
    && tar -xvf ngx_cache_purge-2.3.tar.gz \
    && tar -xvf fastdfs-nginx-module.tar.gz \
    && rm -rf *.tar.gz \
    && echo "Install libfastcommon" \
    && cd ${SRC_DIR}/libfastcommon \
    && ./make.sh \
    && ./make.sh install \
    && echo "Install FastDFS" \
    && cd ${SRC_DIR}/fastdfs \
    && ./make.sh \
    && ./make.sh install \
    && echo "Install Nginx" \
    && cd ${SRC_DIR}/nginx-1.6.3 \
    && ./configure --add-module=${SRC_DIR}/fastdfs-nginx-module/src --add-module=${SRC_DIR}/ngx_cache_purge-2.3 \
    && make \
    && make install \
    && rm -rf ${SRC_DIR}/* \
    && ln -sf /usr/lib64/* /usr/lib/ \
    && ldconfig \
    && apt-get remove -y git wget build-essential \
    && apt autoremove -y \
    && apt clean

RUN sed -i 's/\/usr\/local\/bin/\/usr\/bin/g' /etc/init.d/fdfs_trackerd && \
    sed -i 's/\/usr\/local\/bin/\/usr\/bin/g' /etc/init.d/fdfs_storaged

COPY entrypoint.sh /

RUN chmod a+x /entrypoint.sh

COPY nginx-ps.conf /etc/supervisor/conf.d

VOLUME ["$TRACKER_PATH", "$STORAGE_PATH", "/etc/fdfs"]

ENTRYPOINT ["/bin/bash","/entrypoint.sh"]

CMD ["/usr/bin/supervisord"]