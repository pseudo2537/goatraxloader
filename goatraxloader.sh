#!/usr/bin/bash

read url
echo $url | python3 loader.py | grep -iE "&quot*" > musicurls

dirname=`cat loaderoutput | grep -iPo "<title>+\S*" | cut -c 8-`
names=`grep -iP "^\d.\s+" loaderoutput`
mkdir -p music/$dirname

sc=0
idx=0
name_arr[0x20]=0

while IFS= read -r line; do
	((idx=idx+1))
	str=`echo $line | cut -b 4-12`
	name_arr[$idx]=`echo ${str// /_}`
done <<< $names

idx=0
while IFS= read -r line; do
	echo $line
	((sc=sc+1))
	((idx=idx+1))
	$(wget "$line" -O music/$dirname/"$sc_${name_arr[$idx]}.mp3")
done < musicurls
