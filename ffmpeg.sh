#!/usr/bin/env bash
#=================================================
#	Recommend OS: Debian/Ubuntu
#	Description: A Simple bash script to deal with audio & video
#	Version: 1.0.0
#	Author: IITII
#	Blog: https://IITII.github.io
#=================================================

#获取aac音频文件
get_aac(){
    ffmpeg -i input.mp4 -vn -acodec copy output.aac
}
#获取mp3文件
get_mp3(){
    ffmpeg -i INPUT -acodec libmp3lame -b:a 320k output.mp3
}
#获取H.264视频流
get_H264(){
    ffmpeg -i output.mp4 -an -vcodec copy -bsf:v h264_mp4toannexb output.h264
}
#整合mp4文件
merge_mp4(){
    
}
#整合mp4和mp3文件
merge_mp4_mp3(){
    ffmpeg -i input.mp3 -i input.mp4 -c copy -f mp4 output.mp4
}
#整合mp4和aac文件
merge_mp4_aac(){
    ffmpeg -i input.aac -i input.h264 -acodec copy -bsf:a aac_adtstoasc -vcodec copy -f mp4 output.mp4
}
#添加srt字幕
add_srt(){
    ffmpeg -i video.avi -vf subtitles=subtitle.srt out.avi
}
#srt字幕转ass
srt_to_ass(){
    ffmpeg -i subtitle.srt subtitle.ass
}
#添加ass字幕
add_ass(){
    ffmpeg -i video.avi -vf "ass=subtitle.ass" out.avi
}