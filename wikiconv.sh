#!/bin/sh

for f in `ls *.txt`
do
    iconv -f EUC -t UTF8 < $f > tmp.txt
	mv tmp.txt $f
done

