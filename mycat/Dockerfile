FROM java:8-jre
USER root
RUN cd / \
    && wget http://dl.mycat.io/1.6.5/Mycat-server-1.6.5-release-20180122220033-linux.tar.gz \
    && tar -zxf Mycat-server-1.6.5-release-20180122220033-linux.tar.gz \
    && rm -rf Mycat-server-1.6.5-release-20180122220033-linux.tar.gz \
    && chmod u+x ./mycat
ENV MYCAT_HOME=/mycat
ENV PATH=$PATH:$MYCAT_HOME/bin
WORKDIR $MYCAT_HOME/bin
EXPOSE 8066 9066
CMD ["./mycat","console"]
