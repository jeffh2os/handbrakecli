#! /bin/bash
# Handbrake Script for Bulk Conversion
# 2021/08/19 Created
# 2021/11/16 Updated


#### Variables Section #####

#### Video Source Directory
source="/directory"

#### Video Output Directory
out="/directory"

#### Temp File Directory
temp="/tmp/videos"

#### Video Codec
video="x265_10bit"
#Video Options: x264 | x264_10bit | nvenc_h264 | x265 | x265_10bit | x265_12bit | nvenc_h265 | mpeg4 | mpeg2 | VP8 | VP9 | theora

#### Audio Codec
audio="flac16"
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

HandBrakeCLI -i $source/$i -o $out/$i -e $video -q 20 -m  --encopts="gpu=0" –all-audio -E $audio $sub  && sleep 1m

done

