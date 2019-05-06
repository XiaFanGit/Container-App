FROM ccr.ccs.tencentyun.com/based-image/centos-7:based

ENV FASTDFS_PATH=/opt/fdfs \
    FASTDFS_BASE_PATH=/var/fdfs \
    PORT= \
    GROUP_NAME= \
    TRACKER_SERVER=

#get all the dependences
RUN yum install -y git gcc make perl \
 && mkdir -p ${FASTDFS_PATH}/libfastcommon \
 && mkdir -p ${FASTDFS_PATH}/fastdfs \
 && mkdir ${FASTDFS_BASE_PATH} \
 && cd ${FASTDFS_PATH}/libfastcommon \
 && git clone --branch V1.0.7 --depth 1 https://github.com/happyfish100/libfastcommon.git ${FASTDFS_PATH}/libfastcommon \
 && ./make.sh \
 && ./make.sh install \
 && rm -rf ${FASTDFS_PATH}/libfastcommon \
 && cd ${FASTDFS_PATH}/fastdfs \
 && git clone --branch V5.05 --depth 1 https://github.com/happyfish100/fastdfs.git ${FASTDFS_PATH}/fastdfs \
 && ./make.sh \
 && ./make.sh install \
 && rm -rf ${FASTDFS_PATH}/fastdfs \
 && yum remove -y git gcc make \
 && yum clean all

EXPOSE 22122 23000 8080 8888
VOLUME ["$FASTDFS_BASE_PATH", "/etc/fdfs"]   

COPY entrypoint.sh /

RUN chmod a+x entrypoint.sh

#ENTRYPOINT ["/entrypoint.sh"]

#CMD ["tracker"]