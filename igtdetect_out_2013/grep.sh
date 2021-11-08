#!/bin/bash

grep -E 'tag=[^O]' igtdetect_out_2013/round-2013_classified.freki > igtdetect_out_2013/grep.txt
sed -i '.original' -e 's/ span_id=[^:]*//g' igtdetect_out_2013/grep.txt 