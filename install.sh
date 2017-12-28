#!/bin/bash

sudo apt-get install git python-pip python3-pip
sudo apt-get update

# install PDFMiner

sudo pip install https://github.com/goulu/pdfminer/zipball/e6ad15af79a26c31f4e384d8427b375c93b03533#egg=pdfminer.six

# install freki

sudo git clone https://github.com/xigt/freki.git

# install igtdetect

sudo git clone https://github.com/xigt/igtdetect.git
cd igtdetect
pip3 install . --process-dependency-links
cp defaults.ini.sample defaults.ini
cd ..

# install lgid

sudo git clone https://github.com/xigt/lgid.git
cd lgid
bash setup-env.sh
cd .. 
