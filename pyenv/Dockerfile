FROM daocloud.io/subaru/alpine:based

RUN mkdir /opt

WORKDIR /opt
        
RUN apk add --no-cache python3 python3-dev py-pip

RUN cd /opt && \
    python3 -m venv py3
