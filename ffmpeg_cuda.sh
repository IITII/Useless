#!/usr/bin/env bash
#=================================================
#	Recommend OS: Debian/Ubuntu
#	Description: A Simple bash script to traversal dir &
#   transcode media file's vcode to libx264
#	Version: 2.0.0
#	Author: IITII
#	Blog: https://IITII.github.io
#=================================================
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

# cuda = false
CUDA=0
log() {
    echo $(date +"%H:%M:%S"): $1
}

ffmpeg_NoCuda() {
    # echo nocuda $CUDA
    # pwd
    # echo $1
    ffmpeg -hide_banner -loglevel panic \
        -i $1 -map 0 -c:v libx264 -c:a copy \
        -f mp4 $1.mp4
    log "Transcoding $1 Finished!!!"
}
# ffmpeg -y -vsync 0 -hwaccel cuvid \
# -c:v h264_cuvid -i input.mp4 -c:a copy  \
# -c:v h264_nvenc -preset slow -profile high \
# -b:v 5M -bufsize 5M -maxrate 10M -qmin 0 \
# -g 250 -bf 2 -temporal-aq 1 -rc-lookahead 20 \
# -i_qfactor 0.75 -b_qfactor 1.1 output.mp4
ffmpeg_Cuda() {
    # echo cuda $CUDA
    # pwd
    # echo $1
    ffmpeg -y -vsync 0 -hwaccel cuvid -c:v h264_cuvid \
        -hide_banner -loglevel panic \
        -i $1 \
        -c:a copy -c:v h264_nvenc -preset slow \
        -profile high -b:v 5M -bufsize 5M \
        -maxrate 10M -qmin 0 -g 250 -bf 2 \
        -temporal-aq 1 -rc-lookahead 20 \
        -i_qfactor 0.75 -b_qfactor 1.1 \
        -f mp4 $1.mp4
    log "Transcoding $1 Finished!!!"
}
check() {
    # Check if user is root
    # [ $(id -u) != "0" ] && {
    #     echo "${CFAILURE}Error: You must be root to run this script${CEND}"
    #     exit 1
    # }

    release="ubuntu"
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
            sudo yum -y install ffmpeg >/dev/null 2>&1
        else
            sudo apt-get update >/dev/null 2>&1
            sudo apt-get install ffmpeg -y >/dev/null 2>&1
        fi
    fi

    # Check CUDA
    log "Checking CUDA..."
    if ffmpeg -hide_banner -buildconf | grep enable |
        grep nvcc >/dev/null 2>&1; then
        CUDA=1
        log "Cuda Support!!!"
    else
        log "No Cuda!!!"
    fi
}
traversal() {
    if [ -d $1 ]; then
        cd $1
        log "cd $(pwd)"
        for TSName in $(ls .); do
            # Traversal Call to get All files & dir
            traversal $TSName $2
        done
        cd ..
        log "cd $(pwd)"
    elif [ -r $1 ]; then
        # pwd
        # echo $1
        log "Checking $1"
        ffprobe -hide_banner -loglevel panic $1 >/dev/null 2>&1
        # Decided by ffprobe's exit code.
        # Media files return 0, other return other.
        if [ $? -eq 0 ]; then
            #echo Check Pass...
            log "Check pass!"
            log "Start Transcoding..."
            if [ $CUDA -eq 1 ]; then
                ffmpeg_Cuda $1 $2
            else
                ffmpeg_NoCuda $1
            fi
            else
            log "$1 is not a media file."
        fi
        log "Next..."
    else
        log "Unable to read $1 !!!"
    fi
}
help() {
    log "Usage: $0 [MediaName]|[DirName] slow|medium|fast"
    log "The First Param is Media Name or Directory."
    log "The Second Param is to control transcode quality."
    log "Note! The Second Param only effective on CUDA Transcoding. "
    log "Note! But you always have to fill this value."
    log "There are three chooses: slow, medium,fast"
    log "As for time: \"slow\" is the slowest. Corresponding \"fast\" is the Fastest."
    log "As for Quality: \"slow\" is the best. Corresponding \"fast\" is the Worst."
    log "Some Examples:"
    log "    $0 dir slow"
    log "    $0 input.mp4 slow"
    log "    $0 input.mp4 medium"
    log "    $0 input.mp4 fast"
}

if [ -n "$2" ]; then
    check
    traversal $1 $2
else
    help
fi
