#!/bin/sh
# euccnv2utf8
# pukiwiki files 
for f in `ls *.txt`
do
   iconv -f EUC -t UTF8 < $f > tmp.txt
	# output tmp.txt and rename dist file name 
	mv tmp.txt $f
done

