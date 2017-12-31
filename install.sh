#!/bin/bash

# create virtualenv
if [ ! -d env ]; then
    echo "Creating virtual enviroment"
    virtualenv -p python3 env
fi

source env/bin/activate

# make sure pip is up to date
pip install -U pip

# install PDFMiner

pip install https://github.com/goulu/pdfminer/zipball/e6ad15af79a26c31f4e384d8427b375c93b03533#egg=pdfminer.six

# install freki

git clone https://github.com/xigt/freki.git
cd freki
pip install .
cd ..

# install igtdetect

git clone https://github.com/xigt/igtdetect.git
cd igtdetect
pip install . --process-dependency-links
cp defaults.ini.sample defaults.ini
chmod +x detect-igt
cd ..

deactivate

# install lgid

git clone https://github.com/xigt/lgid.git
cd lgid
bash setup-env.sh
cd .. 
