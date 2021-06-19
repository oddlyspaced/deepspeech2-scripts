#!/bin/bash

# Generates train.csv
# wav_filename,wav_filesize,transcript
# common_voice_hi_23795246.wav,108332,मैं पूरी रात रोई।

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
