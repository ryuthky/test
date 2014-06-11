#!/bin/sh
# euccnv2utf8
# pukiwiki files conv
for f in `ls *.txt`
do

	# convert file encode output tmp.txt
    iconv -f EUC -t UTF8 < $f > tmp.txt
	# rename dist filename
	mv tmp.txt $f
done

