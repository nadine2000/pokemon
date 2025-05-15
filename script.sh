#!/bin/bash

sudo apt update
sudo apt install -y python3-pip git

git clone https://github.com/yourusername/pokemon_app.git
cd pokemon_app

pip3 install requests

python3 main.py
