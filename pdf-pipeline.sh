#!/bin/bash

# print help message if needed
if [ "$1" == "--help" ]; then
    echo "Usage: pdf-pipeline.sh <pdf-file> <output-dir>"
    echo -e "Required arguments: pdf-file\tThe PDF file to run the pipeline on."
    echo -e "\t\toutput-dir\tThe directory to place output files in."
    exit 0
fi

# check for virtual environment
if [ ! -d env ]; then
    echo "Please run install.sh first."
	exit 1
fi

source env/bin/activate

# (1) pdf to xml:

file_name=$(basename $1)
name=${file_name%.pdf}
output_dir=$2

txt="$name.txt"
output_txt="$output_dir/pdf_out/$txt"

mkdir -p $output_dir/pdf_out

pdf2txt.py -o $output_txt -t xml $1

# (2) xml to freki:

freki="$name.freki"
output_freki="$output_dir/freki_out/$freki"

./freki/freki.sh -r pdfminer $output_txt $output_freki

# run ling classifier

# (3) detect igt instances

classified_out="$output_dir/igtdetect_out"
if [ ! -d $classified_out ]; then
    mkdir -p $classified_out
fi

cd ./igtdetect
./detect-igt test --test-files ../$output_freki --classifier-path data/sample.model --classified-dir ../$classified_out
cd ..

deactivate

# exit if no igtdetect features were found (to avoid crashing when the right file isn't found)
if [ ! -f $classified_out/$name"_classified.freki" ]; then
    echo "No igtdetect features found in $name.pdf. Exiting."
    exit 1
fi

# (4) classify igt instances for language

output_lgid=$"$output_dir/lgid_out"

cd ./lgid
./lgid.sh -v classify --model=model/sample.model --out=../$output_lgid config.ini ../$classified_out/$name"_classified.freki"
cd ..
