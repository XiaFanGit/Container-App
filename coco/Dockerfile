FROM daocloud.io/subaru/pvenv

ENV coco_version=1.4.4
 
COPY run.sh /usr/local/bin/run.sh

RUN apk add --no-cache gcc g++ make automake linux-headers sshpass libffi-dev krb5-dev libressl-dev

RUN wget https://github.com/jumpserver/coco/archive/${coco_version}.tar.gz -O /opt/coco.tar.gz \
    && cd /opt \
    && tar zxf coco.tar.gz \
    && ln -sv coco-${coco_version} coco \
    && rm -rf /opt/coco.tar.gz \
    && source /opt/py3/bin/activate \ 
    && pip install -r /opt/coco/requirements/requirements.txt  \
    && wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.1/dumb-init_1.2.1_amd64 \
    && chmod a+x /usr/local/bin/dumb-init \
    && chmod a+x /usr/local/bin/run.sh

RUN apk del gcc g++ make automake

EXPOSE 2222 5000

ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]

CMD ["/usr/local/bin/run.sh"]
