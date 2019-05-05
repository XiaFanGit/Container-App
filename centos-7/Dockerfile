FROM daocloud.io/library/centos:7

ENV TZ=Asia/Shanghai

RUN yum clean all && \
    yum makecache && \
    yum -y install glibc-common kde-l10n-Chinese wget && \
    yum clean all && \
    localedef -c -f UTF-8 -i zh_CN zh_CN.utf8 && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone

ENV LANG=zh_CN.UTF-8 \
    LC_ALL=zh_CN.UTF-8