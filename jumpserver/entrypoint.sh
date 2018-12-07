#!/bin/sh -e

source /opt/py3/bin/activate

cd /opt/jumpserver/utils
sh make_migrations.sh
cd .. 

python run_server.py
