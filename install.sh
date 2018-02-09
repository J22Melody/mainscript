#!/bin/bash

# create virtualenv
if [ ! -d env ]; then
    echo "Creating virtual enviroment"
    virtualenv -p python3 env
fi

source env/bin/activate

# make sure pip is up to date
#   this is in two parts in case virtualenv installs an old version of pip that doesn't support version
#   specifiers - we first install a new version of pip that supports version specifiers and then install
#   the correct version of pip
pip install -U pip
# keep pip at 9.0.* in case dependency link processing is deprecated in the future, because we need that
pip install -U pip~=9.0.1

# install PDFMiner

pip install https://github.com/goulu/pdfminer/zipball/e6ad15af79a26c31f4e384d8427b375c93b03533#egg=pdfminer.six

# install freki

if [ ! -d freki ]; then
    git clone https://github.com/xigt/freki.git
fi
cd freki
pip install .
cd ..

# install igtdetect

if [ ! -d igtdetect ]; then
    curl -s -L https://github.com/xigt/igtdetect/releases/latest | egrep -o '/xigt/igtdetect/releases/download/v?[0-9\.]*/code_and_model.zip' | wget --base=http://github.com/ -i - -O code_and_model.zip
    unzip code_and_model.zip
    rm -f code_and_model.zip
fi
cd igtdetect
pip install . --process-dependency-links
pip install -U scikit-learn==0.19.1 # the included model was trained on this version, so we'll switch to it
cp defaults.ini.sample defaults.ini
chmod +x detect-igt
cd ..

deactivate

# install lgid and download crubadan data

if [ ! -d lgid ]; then
    curl -s -L https://github.com/xigt/lgid/releases/latest | egrep -o '/xigt/lgid/releases/download/v?[0-9\.]*/code_and_data.zip' | wget --base=http://github.com/ -i - -O code_and_data.zip
    unzip code_and_data.zip
    rm -f code_and_data.zip
fi
cd lgid
bash setup-env.sh
if [ "$1" != "--no-crubadan" ]; then
    echo "Downloading Crubadan language models. This might take a while..."
    bash lgid.sh -vv download-crubadan-data config.ini
fi
cd ..
