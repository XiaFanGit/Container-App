FROM daocloud.io/subaru/coco:based
    
COPY conf.py /opt/coco/conf.py

EXPOSE 2222 5000

CMD source /opt/py3/bin/activate && cd /opt/coco && python ./run_server.py
