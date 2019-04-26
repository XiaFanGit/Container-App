FROM ccr.ccs.tencentyun.com/based-server/jdk-mvn:based

USER root
# Jenkins will be running on a Mesos cluster, add mesos libs in addition to the usual packages
RUN rpm -Uvh http://repos.mesosphere.io/el/7/noarch/RPMS/mesosphere-el-repo-7-2.noarch.rpm && \
    rpm -Uvh http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key && \
    curl https://pkg.jenkins.io/redhat-stable/jenkins.repo > /etc/yum.repos.d/jenkins.repo && \
    yum makecache && \
    yum -y install curl git jenkins jq mesos unzip zip && \
    yum clean all

COPY run-jenkins.sh /usr/local/bin/
RUN chmod a+x /usr/local/bin/run-jenkins.sh

ENV JENKINS_HOME=/var/lib/jenkins \
    JENKINS_SLAVE_AGENT_PORT=50000

# For the main web interface
EXPOSE 8080

# Used by build workers
EXPOSE 50000

USER jenkins

ENTRYPOINT [ "/usr/local/bin/run-jenkins.sh" ]
