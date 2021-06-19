#!/bin/bash

# Converts .flac files found in LibriSpeech database to .wav using ffmpeg

find -iname "*.flac" > files.txt
while read file; do
  convertfile=$(echo $file | awk -F ".flac" '{print $1".wav"}')
  if [[ $file != .* ]]; then
	  file=".$file"
  fi
  if [[ $convertfile != .* ]]; then
	  convertfile=".$convertfile"
  fi
  echo "$file"
  echo "$convertfile"
  ffmpeg -i $file $convertfile
  rm $file
  echo "-----------------"
done <files.txt
