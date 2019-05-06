FROM ccr.ccs.tencentyun.com/based-image/centos-7:based

ENV JAVA_HOME=/usr/local/jdk1.8 \
    MAVEN_HOME=/usr/local/maven3

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
