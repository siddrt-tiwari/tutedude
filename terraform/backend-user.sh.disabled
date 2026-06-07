#!/bin/bash
set -e

apt-get update -y

apt-get install -y \
git \
curl

curl -fsSL https://deb.nodesource.com/setup_20.x | bash -

apt-get install -y nodejs

cd /opt

git clone https://github.com/siddrt-tiwari/tutedude.git app

cd /opt/app/Backend

npm install

nohup npm start > /var/log/backend.log 2>&1 &