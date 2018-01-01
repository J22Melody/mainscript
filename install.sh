#!/bin/bash

# create virtualenv
if [ ! -d env ]; then
    echo "Creating virtual enviroment"
    virtualenv -p python3 env
fi

source env/bin/activate

# make sure pip is up to date, but keep at 9.0.* in case dependency link processing is deprecated
# in the future, because we need that
pip install -U pip~=9.0.1

# install PDFMiner

pip install https://github.com/goulu/pdfminer/zipball/e6ad15af79a26c31f4e384d8427b375c93b03533#egg=pdfminer.six

# install freki

if [ ! -d freki ]; then
    git clone https://github.com/xigt/freki.git
else
    cd freki
    git pull
    cd ..
fi
cd freki
pip install -U .
cd ..

# install igtdetect

if [ ! -d lgid ]; then
    git clone https://github.com/xigt/igtdetect.git
else
    cd igtdetect
    git pull
    cd ..
fi
cd igtdetect
pip install -U . --process-dependency-links --upgrade-strategy eager
cp defaults.ini.sample defaults.ini
chmod +x detect-igt
cd ..

deactivate

# install lgid

if [ ! -d lgid ]; then
    git clone https://github.com/xigt/lgid.git
else
    cd lgid
    git pull
    cd ..
fi
cd lgid
bash setup-env.sh
cd ..
