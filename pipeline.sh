#!/bin/bash

# check for virtual environment
if [ ! -d env ]; then
    echo "Please run install.sh first."
	exit 1
fi

source env/bin/activate

# text 
# pdf to freki:

## (1) pdf to xml:

file_name=$(basename $1)
name=${file_name%.pdf}
output_dir=$2

txt="$name.txt"
output_txt="$output_dir/$txt"

mkdir -p $output_dir

pdf2txt.py -o $output_txt -t xml $1

## (2) xml to freki:

freki="$name.freki"
output_freki="$output_dir/$freki"

./freki/freki.sh -r pdfminer $output_txt $output_freki

# run ling classifier

# if it is ling doc, run igt-detect and lang-id

classified_out="$output_dir/igtdetect_out"

cd ./igtdetect
./detect-igt test --test-files ../$output_txt --classifier-path data/igt-classifier-nobio.model --classified-dir $classified_out
cd ..

deactivate

output_out=$"$output_dir/lgid_out"

cd ./lgid
./lgid.sh -v classify --model=model/sample_model --out=../$output_out config.ini ../$classified_out/$freki
cd ..
