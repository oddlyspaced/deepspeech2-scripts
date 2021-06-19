#!/bin/bash

# Generates csv file for provided libri dataset

# wav_filename,wav_filesize,transcript
# file.wav,108332,test test

inpfile=$(echo $1 | awk -F "/" '{print $NF}')
dir=$(echo $1 | awk -F "$inpfile" '{print $1}')
output=$2

cd $dir

echo "wav_filename,wav_filesize,transcript" > $2
while read line; do
	file="$(echo $line | awk -F " " '{print $1}').wav"
	size=$(du -sh $file --bytes | awk -F " " '{print $1}')
	trans=$(echo $line | cut -d " " -f 2-)
	echo "$file,$size,${trans,,}" >> $2
done <$inpfile

cd -

echo "Created $dir$2"
