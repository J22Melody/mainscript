#!/bin/bash

# install PDFMiner

sudo pip3 install https://github.com/goulu/pdfminer/zipball/e6ad15af79a26c31f4e384d8427b375c93b03533#egg=pdfminer.six

# install freki

git clone https://github.com/xigt/freki.git

# install igtdetect

git clone https://github.com/xigt/igtdetect.git
cd igtdetect
sudo pip3 install . --process-dependency-links
cp defaults.ini.sample defaults.ini
chmod +x detect-igt
cd ..

# install lgid

if ! $( virtualenv 2>/dev/null >/dev/null ); then
	sudo pip3 install virtualenv
fi
git clone https://github.com/xigt/lgid.git
cd lgid
bash setup-env.sh
cd .. 
