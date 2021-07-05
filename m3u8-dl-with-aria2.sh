#!/bin/bash
# author: MRX
# 2021-07-05

m3u8url=`cat $1 | sed -n '1p'`
echo "download from "$m3u8url
m3u8filename=`basename $m3u8url`
echo "m3u8 file: "$m3u8filename
cookie=`cat $1 | sed -n '2p'`
#echo "cookie:"$cookie

# download m3u8 file
aria2c -c -x30 --header="Cookie:$cookie" -o $m3u8filename $m3u8url 

# create ts download list
urlpre=`dirname $m3u8url`
listFile=`echo "$m3u8filename" |sed 's/\.m3u8/_m3u8\.txt/g'`
sed -n /^[^#]/p $m3u8filename > $listFile
sed -i "s|^|$urlpre/|g" $listFile
echo "ts list: "$listFile

# download ts files
mkdir tstemp
aria2c -c -x30 -j30 --dir=tstemp --header="Cookie:$cookie" --input-file=$listFile
mv $m3u8filename tstemp
cd tstemp

# merge video
outputfilenamets=`echo "$m3u8filename" |sed 's/\.m3u8/\.ts/g'`
outputfilenamemkv=`echo "$m3u8filename" |sed 's/\.m3u8/\.mkv/g'`
echo "output: "$outputfilenamets
ffmpeg -i $m3u8filename -vcodec copy -acodec copy $outputfilenamets
mv $outputfilenamets ../
cd ../
rm -r tstemp

# convert to mkv
ffmpeg -hwaccel cuvid -c:v h264_cuvid -i $outputfilenamets -map 0 -vcodec copy -acodec copy -f matroska $outputfilenamemkv 
