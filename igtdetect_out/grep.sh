#!/bin/bash

grep -E 'tag=[^O]' igtdetect_out/round-2013_classified.freki > igtdetect_out/grep.txt
sed -i '.original' -e 's/ span_id=[^:]*//g' igtdetect_out/grep.txt 