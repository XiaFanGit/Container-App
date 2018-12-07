FROM daocloud.io/subaru/pvenv

RUN cd /opt \
    && source /opt/py3/bin/activate \
    && apk add --no-cache gcc g++ make automake git libgss krb5-libs libjpeg sshpass mysql-dev openldap-dev openssh-client \
    && apk add --no-cache glib-dev krb5-dev zlib-dev freetype-dev tiff-dev libzip-dev lcms2-dev tcl-dev libwebp-dev tk-dev libffi-dev \
    && git clone https://github.com/jumpserver/jumpserver.git \
    && pip install -r /opt/jumpserver/requirements/requirements.txt

RUN apk del gcc g++ make automake

VOLUME /opt/jumpserver/data

EXPOSE 8080

CMD source /opt/py3/bin/activate && cd /opt/jumpserver/utils && sh make_migrations.sh && cd .. && python run_server.py
