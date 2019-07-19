#!/usr/bin/env bash
#=================================================
#	Recommend OS: Debian/Ubuntu
#	Description: A Simple bash script to deal with audio & video
#   Update：2019年 05月 01日 星期三 01:10:48 CST
#   Create：2019年 04月 30日 星期三 20:10:48 CST
#	Version: 1.0.0
#	Author: IITII
#	Blog: https://IITII.github.io
#=================================================

#获取aac音频文件
get_aac() {
    ffmpeg -i $1 -vn -acodec copy $2.aac
}
#获取mp3文件
get_mp3() {
    ffmpeg -i $1 -acodec libmp3lame -b:a 320k $2.mp3
}
#获取H.264视频流
get_H264() {
    ffmpeg -i $1 -an -vcodec copy -bsf:v h264_mp4toannexb $2.mp4
}
#整合mp4文件
merge_mp4() {
    ffmpeg -i $1 -acodec libmp3lame -b:a 320k - | ffmpeg -i - -i $2 -acodec copy -bsf:a aac_adtstoasc -vcodec copy -f mp4 $3.mp4
}
#整合mp4和mp3文件
merge_mp4_mp3() {
    ffmpeg -i $1 -i $2 -c copy -f mp4 $3.mp4
}
#整合mp4和aac文件
merge_mp4_aac() {
    ffmpeg -i $1 -i $2 -acodec copy -bsf:a aac_adtstoasc -vcodec copy -f mp4 $3
}
#添加srt字幕
add_srt() {
    ffmpeg -i $1 -vf subtitles=$2 $3
}
#srt字幕转ass
srt_to_ass() {
    ffmpeg -i $1 $2.ass
}
#添加ass字幕
add_ass() {
    ffmpeg -i $1 -vf "ass=$2" $3
}
#交互选择界面
cmd_interaction() {
    echo -e "请选择你要选择的操作的序号：\n"
    echo -e "* 所有文件名请完整输入文件名称，包括后缀名！\n"
    echo -e "1.获取aac音频文件"
    echo -e "2.获取mp3文件"
    echo -e "3.获取H.264视频流文件(.mp4文件)"
    echo -e "4.整合mp4文件和mp4文件"
    echo -e "5.整合mp4和mp3文件"
    echo -e "6.整合mp4和aac文件"
    echo -e "7.添加srt字幕"
    echo -e "8.srt字幕转ass"
    echo -e "9.添加ass字幕"
    read i
    case $i in
    1)
        read -p "请输入源文件名称：" input_mp4
        read -p "请输入要获取的文件名称: " output_aac
        get_aac $input_mp4 $output_aac
        ;;
    2)
        read -p "请输入源文件名称：" input_mp4
        read -p "请输入要获取的文件名称: " output_mp3
        get_mp3 $input_mp4 $output_mp3
        ;;
    3)
        read -p "请输入源文件名称：" input_mp4
        read -p "请输入要获取的文件名称: " output_mp4
        get_H264 $input_mp4 $output_mp4
        ;;
    4)
        read -p "请输入音频文件名称：" input_mp41
        read -p "请输入视频文件名称：" input_mp42
        read -p "请输入要获取的文件名称: " output_mp4
        merge_mp4 $input_mp41 $input_mp42 $output_mp4
        ;;
    5)
        read -p "请输入mp3文件名称：" input_mp3
        read -p "请输入mp4文件名称：" input_mp4
        read -p "请输入要获取的文件名称: " output_mp4
        merge_mp4_mp3 $input_mp3 $input_mp4 $output_mp4
        ;;
    6)
        read -p "请输入aac文件名称：" input_aac
        read -p "请输入mp4文件名称：" input_mp4
        read -p "请输入要获取的文件名称: " output_mp4
        merge_mp4_aac $input_aac $input_mp4 $output_mp4
        ;;
    7)
        read -p "请输入视频文件名称：" input_mp4
        read -p "请输入srt文件名称：" input_srt
        read -p "请输入要获取的视频文件名称: " output_mp4
        add_srt $input_mp4 $input_srt $output_mp4
        ;;
    8)
        read -p "请输入源文件名称：" input_srt
        read -p "请输入要获取的文件名称: " output_ass
        srt_to_ass $input_srt $output_ass
        ;;
    9)
        read -p "请输入视频文件名称：" input_mp4
        read -p "请输入srt文件名称：" input_ass
        read -p "请输入要获取的视频文件名称: " output_mp4
        add_ass $input_mp4 $input_ass $output_mp4
        ;;
    *)
        echo "请输入有效数字！！！"
        ;;
    esac
}
#命令行参数处理

#######################################################
#安装ffmpeg
if ! command -v ffmpeg >/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install ffmpeg -y
fi
#######################################################
#若使用命令行传参直接跳过交互过程
if [ ! -n "$1" ]; then
    cmd_interaction
fi
while getopts "m:he" arg; do #选项后面的冒号表示该选项需要参数
    case $arg in
    m)
        #echo "a's arg:$OPTARG" #参数存在$OPTARG中
        shift
        case $OPTARG in
        1)
            get_aac $1 $2
            ;;
        2)
            get_mp3 $1 $2
            ;;
        3)
            get_H264 $1 $2
            ;;
        4)
            merge_mp4 $1 $2 $3
            ;;
        5)
            merge_mp4_mp3 $1 $2 $3
            ;;
        6)
            merge_mp4_aac $1 $2 $3
            ;;
        7)
            add_srt $1 $2 $3
            ;;
        8)
            srt_to_ass $1 $2
            ;;
        9)
            add_ass $1 $2 $3
            ;;
        *)
            echo "请输入有效数字！！"
            ;;
        esac
        ;;
    h)
        echo "-h: To show this menu"
        echo "-e: Show Some Useful Templates"
        echo "-m [1-9]: To switch mode"
        echo "              -m 1: 获取aac音频文件"
        echo "              -m 2: 获取mp3文件"
        echo "              -m 3: 获取H.264视频流文件(.mp4文件)"
        echo "              -m 4: 整合mp4文件和mp4文件"
        echo "              -m 5: .整合mp4和mp3文件"
        echo "              -m 6: 整合mp4和aac文件"
        echo "              -m 7: 添加srt字幕"
        echo "              -m 8: srt字幕转ass"
        echo "              -m 9: 添加ass字幕"
        ;;
    e)
        echo -e "./ffmpeg.sh -m 1 input.mp4 output.aac"
        echo -e "./ffmpeg.sh -m 2 input.mp4 output.mp3"
        echo -e "./ffmpeg.sh -m 3 input.mp4 output.mp4"
        echo -e "./ffmpeg.sh -m 4 input_audio.mp4 input_video.mp4 output.mp4"
        echo -e "./ffmpeg.sh -m 5 input.mp3 input.mp4 output.mp4"
        echo -e "./ffmpeg.sh -m 6 input.aac input.mp4 output.mp4"
        echo -e "./ffmpeg.sh -m 7 input.mp4 input.srt output.mp4"
        echo -e "./ffmpeg.sh -m 8 input.srt output.ass"
        echo -e "./ffmpeg.sh -m 9 input.mp4 input.ass output.mp4"
        ;;
    ?) #当有不认识的选项的时候arg为?
        echo "unkonw argument"
        exit 1
        ;;
    esac
done
