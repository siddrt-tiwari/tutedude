#!/bin/bash
set -e

apt-get update -y

apt-get install -y \
git \
python3 \
python3-pip \
python3-venv

cd /opt

git clone https://github.com/siddrt-tiwari/tutedude.git app

cd /opt/app/Frontend

python3 -m venv venv

source venv/bin/activate

pip install -r requirements.txt

nohup python3 app.py > /var/log/frontend.log 2>&1 &