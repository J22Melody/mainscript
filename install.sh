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

if ! $( pdf2txt.py -h 2>/dev/null >/dev/null ); then
    pip install https://github.com/goulu/pdfminer/zipball/e6ad15af79a26c31f4e384d8427b375c93b03533#egg=pdfminer.six
fi

# install freki

if [ ! -d freki ]; then
    git clone https://github.com/xigt/freki.git
fi
cd freki
pip install .
cd ..

# install igtdetect

if [ ! -d igtdetect ]; then
    git clone https://github.com/xigt/igtdetect.git
fi
cd igtdetect
pip install . --process-dependency-links
cp defaults.ini.sample defaults.ini
chmod +x detect-igt
cd ..

deactivate

# install lgid

if [ ! -d lgid ]; then
    git clone https://github.com/xigt/lgid.git
fi
cd lgid
bash setup-env.sh
cd ..
