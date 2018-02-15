#!/bin/bash

# print help message if needed
if [ "$1" == "--help" ]; then
    echo "Usage: text-pipeline.sh <text-file> <output-dir> [<igt-file>]"
    echo -e "Required arguments:"
    echo -e "tpdf-file\tThe text file to run the pipeline on."
    echo -e "\toutput-dir\tThe directory to place output files in."
    echo ""
    echo -e "Optional arguments:"
    echo -e "\tigt-file\tA  file specifying locations of IGT instances in the text file"
    exit 0
fi

# check for virtual environment
if [ ! -d env ]; then
    echo "Please run install.sh first."
	exit 1
fi

source env/bin/activate

# (1) text to freki:

file_name=$(basename $1)
name=${file_name%.txt}
output_dir=$2

freki="$name.freki"
output_freki="$output_dir/freki_out/$freki"

if [ $# -eq 3 ]; then
	./freki/text-to-freki.sh $1 $output_freki --igtfile $3
else
	./freki/text-to-freki.sh $1 $output_freki
fi

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
