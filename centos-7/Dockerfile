FROM daocloud.io/library/centos:7

ENV TZ=Asia/Shanghai \
    JAVA_HOME=/usr/local/jdk1.8 \
    MAVEN_HOME=/usr/local/maven3

RUN yum clean all && \
    yum makecache && \
    yum -y install glibc-common kde-l10n-Chinese wget && \
    yum clean all && \
    localedef -c -f UTF-8 -i zh_CN zh_CN.utf8 && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone

ENV LANG=zh_CN.UTF-8 \
    LC_ALL=zh_CN.UTF-8

# JDK 1.8 & Maven 3
RUN cd /tmp && \
    wget https://emiya-1251100968.cos.ap-chengdu.myqcloud.com/Linux/tar.gz/jdk-8u211-linux-x64.tar.gz && \
    wget https://emiya-1251100968.cos.ap-chengdu.myqcloud.com/Linux/tar.gz/apache-maven-3.3.9-bin.tar.gz && \
    tar -xzvf jdk-8u211-linux-x64.tar.gz && \
    tar -xzvf apache-maven-3.3.9-bin.tar.gz && \
    mv jdk1.8.0_211 /usr/local/jdk1.8 && \
    mv apache-maven-3.3.9 /usr/local/maven3 && \
    ln -sf /usr/local/jdk1.8/bin/* /usr/bin/ && \
    ln -sf /usr/local/maven3/bin/* /usr/bin/ && \
    rm -rf *
