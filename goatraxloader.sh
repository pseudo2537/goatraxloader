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


unique=0
declare -A dict

idx=0
while IFS= read -r line; do
	#echo $line
	((sc=sc+1))
	((idx=idx+1))
	s_name="$sc_${name_arr[$idx]}.mp3"
	#check if same name already given and name not empty
	if [[ $s_name == ".mp3" ]] || [[ dict[$s_name] -eq 1 ]]; then
		echo "OK"
		s_name="$unique$s_name"	
		echo $s_name
		((++unique))
	fi	
	$(wget "$line" -O music/$dirname/$s_name)
	dict[$s_name]=1
	#debug
	#echo ${dict[$s_name]}
done < musicurls

echo ${dict[@]}
