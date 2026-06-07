#!/bin/bash
set -e

# Log everything

exec > >(tee /var/log/user-data.log)
exec 2>&1

echo "Starting bootstrap..."

#########################################

# Update packages

#########################################

apt-get update -y

#########################################

# Install dependencies

#########################################

apt-get install -y
git
curl
python3
python3-pip
python3-venv

#########################################

# Install NodeJS 20

#########################################

curl -fsSL https://deb.nodesource.com/setup_20.x | bash -

apt-get install -y nodejs

#########################################

# Clone repository

#########################################

cd /opt

git clone YOUR_GITHUB_REPO_URL app

#########################################

# Start Express Backend

#########################################

cd /opt/app/backend

npm install

nohup npm start > /var/log/backend.log 2>&1 &

#########################################

# Start Flask Frontend

#########################################

cd /opt/app/frontend

python3 -m venv venv

source venv/bin/activate

pip install -r requirements.txt

nohup python app.py > /var/log/frontend.log 2>&1 &

echo "Bootstrap completed successfully"