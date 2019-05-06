FROM ccr.ccs.tencentyun.com/based-image/jdk-mvn:based

RUN yum -y install git unzip epel-release && \
    yum -y install supervisor && \
    yum clean all && \
    rm -rf /usr/local/maven3/conf/settings.xml

COPY jenkins-slave.conf /etc/supervisord.d/

# Put Your Maven Config 
# COPY settings.xml /usr/local/maven3/conf/

CMD ["/usr/bin/supervisord"]