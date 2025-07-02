#!/bin/bash

sudo apt update
sudo apt install -y python3-pip git

pip3 install requests
pip3 install boto3

git clone https://github.com/nadine2000/pokemon
cd pokemon

python3 main.py
