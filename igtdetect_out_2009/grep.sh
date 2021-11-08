#!/bin/bash

grep -E 'tag=[^O]' igtdetect_out_2009/round-2009_classified.freki > igtdetect_out_2009/grep.txt
sed -i '.original' -e 's/ span_id=[^:]*//g' igtdetect_out_2009/grep.txt 