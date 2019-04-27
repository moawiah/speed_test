#!/usr/bin/env bash

echo "Test Started"

data=`speedtest-cli`

##Getting the needed values
download=`grep 'Download' <<< $data | cut -d' ' -f 2`
upload=`grep 'Upload' <<< $data | cut -d' ' -f 2`
date=`date +"%d.%m.%Y"`
time=`date +"%T"`

file=speed_test.csv
header='date,time,download,upload'

##Creating the file if running for the first time and insert out header line
if [ ! -f "$file" ]
then
	echo $header >> $file
fi

##Design some regex to validate the values before pasting to the file
number='^[0-9]+([.][0-9]+)?$'
date_format='^[0-9]{2}.[0-9]{2}.[0-9]{4}$'
time_format='^[0-9]{2}:[0-9]{2}:[0-9]{2}$'

##If validation is fine --> past results to file
if [[ $download =~ $number ]] && [[ $upload =~ $number ]] && [[ $date =~ $date_format ]] && [[ $time =~ $time_format ]]; then
    echo $date,$time,$download,$upload >> $file
    echo "Values are successfully written to $file, Test Ended"
else
	echo "Internal Error Occurred"
	exit 1
fi





