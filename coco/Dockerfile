FROM daocloud.io/subaru/coco:based

WORKDIR /opt/coco

EXPOSE 2222 5000

RUN  echo > config.yml

CMD source /opt/py3/bin/activate && cd /opt/coco && python ./run_server.py
