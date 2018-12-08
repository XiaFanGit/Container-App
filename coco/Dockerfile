FROM daocloud.io/subaru/pvenv

ENV coco_version=1.4.4
 
RUN apk add --no-cache gcc g++ make automake linux-headers sshpass libffi-dev krb5-dev libressl-dev

RUN wget https://github.com/jumpserver/coco/archive/${coco_version}.tar.gz -O /opt/coco.tar.gz \
    && cd /opt \
    && tar zxf coco.tar.gz \
    && ln -sv coco-${coco_version} coco \
    && rm -rf /opt/coco.tar.gz \
    && source /opt/py3/bin/activate \ 
    && pip install -r /opt/coco/requirements/requirements.txt \
    && apk del gcc g++ make automake

EXPOSE 2222 5000

CMD source /opt/py3/bin/activate && cd /opt/coco && python ./run_server.py
