#! /bin/bash
# Handbrake Script for Bulk Conversion
# 2021/08/19 Created
# 2021/11/16 Updated

#debug if needed
#set -x
#trap read debug


#Logging
DATE=$(date +"%Y-%m-%d_%H:%M-[%Z]")
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>~/handbrake-${DATE}.log 2>&1

#### Variables Section #####

#### Video Source Directory
source="/home/jeff/rip2/handbrake"

#### Video Output Directory
out="/home/jeff/rip"

#### Temp File Directory
temp="/tmp/videos"

#### Video Codec
video="x265_10bit"
#Video Options: x264 | x264_10bit | nvenc_h264 | x265 | x265_10bit | x265_12bit | nvenc_h265 | mpeg4 | mpeg2 | VP8 | VP9 | theora

#### Audio Codec
#audio="flac16"
#Audio Options: none | av_aac | copy:aac | ac3 | copy:ac3 | eac3 | copy:eac3 | copy:truehd | copy:dts | copy:dtshd | copy:mp2 | mp3 | copy:mp3 | vorbis | flac16 | flac24 | copy:flac | opus | copy


#### Subtitle Settings
sub="--all-subtitles"



#### Start Script ####
####clean up previous list
find $temp -delete

#### Grab all video files and dump names to temp location
ls $source >> $temp

#### Handbrake Batch Conversion 
for i in $(cat $temp)

do 

if [[ $(mkvinfo ${source}/${i} |grep "Bit depth:" |awk '{print $5}'|head -1) == "24" ]]
    then 
        audio="flac24"
        echo "UPDATE: 24 bit audio found" 
    else
       audio="flac16"
       echo "UPDATE: 16 bit audio found" 
fi       

#if [[ $(echo ${i} |grep "chapters") ]]
#then
#    chapters=$echo ${i}|cut -d',' -f1}
#fi

echo "UPDATE: Encoding $i" 
HandBrakeCLI -i $source/$i -o $out/$i ${chapter} -e $video -q 20 -m --encopts="gpu=1" --all-audio -E $audio $sub && sleep .5
echo "UPDATE: All Work Complete!"
done

