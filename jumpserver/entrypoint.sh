#!/bin/sh -e

source /opt/py3/bin/activate

sentinel=/opt/jumpserver/data/inited

if [ -f ${sentinel} ];then
        echo "Database have been inited"
else
    cd /opt/jumpserver/utils
    sh make_migrations.sh
    echo "Database init success"
    touch $sentinel
fi

cd /opt/jumpserver/
python run_server.py
