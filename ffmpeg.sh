#!/usr/bin/env bash
#=================================================
#	Recommend OS: Debian/Ubuntu
#	Description: A Simple bash script to deal with audio & video
#   Update：2019年 08月 27日 星期三 01:10:48 CST
#   Create：2019年 04月 30日 星期三 20:10:48 CST
#	Version: 2.0.0
#	Author: IITII
#	Blog: https://IITII.github.io
#=================================================

# Check if user is root
[ $(id -u) != "0" ] && {
    echo "${CFAILURE}Error: You must be root to run this script${CEND}"
    exit 1
}

declare release="ubuntu"
# Check release
if [ -f /etc/redhat-release ]; then
    release="centos"
elif cat /etc/issue | grep -Eqi "debian"; then
    release="debian"
elif cat /etc/issue | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /etc/issue | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
elif cat /proc/version | grep -Eqi "debian"; then
    release="debian"
elif cat /proc/version | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /proc/version | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
fi

# checking ffmpeg
# If don't have it, print some infomation & auto install it from release repo
# else do nothing
if ! command -v ffmpeg >/dev/null 2>&1; then
    echo "Installing ffmpeg from $release repo"
    if [ "${release}" == "centos" ]; then
        yum -y install ffmpeg >/dev/null 2>&1
    else
        apt-get update >/dev/null 2>&1
        apt-get install ffmpeg -y >/dev/null 2>&1
    fi
fi

# get aac audio stream from a video or audio file and save it as a aac file
# `get_aac input.mp4 output` = `ffmpeg -i input.mp4 -vn -acodec copy output.aac`
get_aac() {
    ffmpeg -i $1 -vn -acodec copy $2.aac
}
# get aac audio stream from a media file and save it as a mp3 file
# `get_mp3 input.mp4 output` = `ffmpeg -i input.mp4 -acodec libmp3lame -b:a 320k output.mp3`
get_mp3() {
    ffmpeg -i $1 -acodec libmp3lame -b:a 320k $2.mp3
}
# get H.264 video stream from a video file & save it as a mp4 file (Without audio)
get_H264() {
    ffmpeg -i $1 -an -vcodec copy -bsf:v h264_mp4toannexb $2.mp4
}
# GET audio from a media file and GET video from another then MERGE both to a mp4 file

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
#剪切视频
# @param $1 输入视频的名称
# @param $2 截取开始时间
# @param $3 截取长度
# @param $4 输出视频名称
#用 -ss 和 -t 选项， 从第 30 秒开始，向后截取 10 秒的视频，并保存：
cut_video_t() {
    ffmpeg -i $1 -ss $2 -c copy -t $3 $4
}
#达成相同效果，也可以用 -ss 和 -to 选项， 从第 30 秒截取到第 40 秒：
# @param $1 输入视频的名称
# @param $2 截取开始时间
# @param $3 截取结束时间
# @param $4 输出视频名称
cut_video_to() {
    ffmpeg -i $1 -ss $2 -c copy -to $3 $4
}
# 值得注意的是，ffmpeg 为了加速，会使用关键帧技术， 所以有时剪切出来的结果在起止时间上未必准确。
# 通常来说，把 -ss 选项放在 -i 之前，会使用关键帧技术；
# 把 -ss 选项放在 -i 之后，则不使用关键帧技术。
# 如果要使用关键帧技术又要保留时间戳，可以加上 -copyts 选项：
# ffmpeg -ss 00:01:00 -i video.mp4 -to 00:02:00 -c copy -copyts cut.mp4

## @param $1 输入视频的名称
# @param $2 倍速
# @param $3 输出视频名称
speed_adjust() {
    # 加速四倍：setpts=0.25*PTS
    # 四倍慢速：setpts=4*PTS
    ffmpeg -i $1 -vf "setpts=$2*PTS" $3
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
    echo -e "10.按开始时间和截取长度截取视频"
    echo -e "11.按开始时间和结束时间截取视频"
    echo -e "12.更改视频的速度"
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
    10)
        read -p "请输入音频文件名称：" input_mp4
        read -p "截取开始时间：" start
        read -p "截取长度：" last
        echo -e "时间格式：00:00:00 (时：分：秒)"
        read -p "请输入要获取的文件名称: " output_mp4
        cut_video_t $input_mp4 $start $last $output_mp4
        ;;
    11)
        read -p "请输入音频文件名称：" input_mp4
        read -p "截取开始时间：" start
        read -p "截取结束时间：" end
        echo -e "时间格式：00:00:00 (时：分：秒)"
        read -p "请输入要获取的文件名称: " output_mp4
        cut_video_to $input_mp4 $start $end $output_mp4
        ;;
    12)
        read -p "请输入视频文件名称：" input_mp4
        read -p "要调整的速度（输入0.25是4倍，输入4是0.25倍）：" speed
        read -p "请输入要获取的视频文件名称: " output_mp4
        speed_adjust $input_mp4 $speed $output_mp4
        ;;

    *)
        echo "请输入有效数字！！！"
        ;;
    esac
}
#命令行参数处理
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
        10)
            cut_video_t $1 $2 $3 $4
            ;;
        11)
            cut_video_to $1 $2 $3 $4
            ;;
        12)
            speed_adjust $1 $2 $3
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
        echo "              -m 5: 整合mp4和mp3文件"
        echo "              -m 6: 整合mp4和aac文件"
        echo "              -m 7: 添加srt字幕"
        echo "              -m 8: srt字幕转ass"
        echo "              -m 9: 添加ass字幕"
        echo "              -m 10: 按开始时间和截取长度截取视频"
        echo "              -m 11: 按开始时间和结束时间截取视频"
        echo "              -m 12: 更改视频的速度"
        ;;
    e)
        echo -e "$0 -m 1 input.mp4 output.aac"
        echo -e "$0 -m 2 input.mp4 output.mp3"
        echo -e "$0 -m 3 input.mp4 output.mp4"
        echo -e "$0 -m 4 input_audio.mp4 input_video.mp4 output.mp4"
        echo -e "$0 -m 5 input.mp3 input.mp4 output.mp4"
        echo -e "$0 -m 6 input.aac input.mp4 output.mp4"
        echo -e "$0 -m 7 input.mp4 input.srt output.mp4"
        echo -e "$0 -m 8 input.srt output.ass"
        echo -e "$0 -m 9 input.mp4 input.ass output.mp4"
        echo -e "截取长度为30秒的视频："
        echo -e "$0 -m 10 input.mp4 00:00:10 00:00:30 output.mp4"
        echo -e "截取长度为30秒的视频："
        echo -e "$0 -m 11 input.mp4 00:00:10 00:00:40 output.mp4"
        echo -e "将视频的播放速度调整为4倍："
        echo -e "$0 -m 12 input.mp4 0.25 output.mp4"
        ;;
    ?) #当有不认识的选项的时候arg为?
        echo "unkonw argument"
        exit 1
        ;;
    esac
done
