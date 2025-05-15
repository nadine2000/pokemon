#!/bin/bash

sudo apt update
sudo apt install -y python3-pip git

git clone https://github.com/nadine2000/pokemon
cd pokemon

pip3 install requests

python3 main.py
