#!/usr/bin/env bash
#=================================================
#	Recommend OS: Debian/Ubuntu
#	Description: A Simple bash script to get filename and Replace the space in filename
#	Version: 1.0.0
#	Author: IITII
#	Blog: https://IITII.github.io
#=================================================
#  注意使用本脚本请先将 aria2.conf 里面的 force-save 这一项的值设置为 false
#  添加一项到配置文件末：echo "on-download-complete=bash ~/Format.sh" >> ~/.aria2/aria2.conf
#  如果没有的话请自行添加，默认配置文件目录：~/.aria2/aria2.conf
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

#set Aria2 download path
downloadPath='/root/movie'
#设置媒体文件转码后的文件夹
media='/root/media'

#设置媒体文件的最小值
#如果第一级子目录下的最大的文件大小小于设定的值，
#则遍历第二级子目录并筛选
#不考虑三层及以上
#默认大小为: 800M
miniSize= expr 800 \* 1024 \* 1024

echo "====================="
echo "["$(date +%Y-%m-%d--%H:%M:%S)"]开始执行"
#fileName=$(ls -S $downloadPath | head -n 1)
#temp=$(ls -S $downloadPath | head -n 1 | sed 's/ /_/g')
check_software() {
    #三种检查命令是否存在的方式
    # 1

    if ! command -v ffmpeg >/dev/null 2>&1; then
        sudo apt-get update
        sudo apt-get install ffmpeg -y
    fi

    # 2
    # if type git >/dev/null 2>&1; then
    #     echo 'exists git'
    # else
    #     echo 'no exists git'
    # fi
    
    # 3
    # if hash git 2>/dev/null; then
    #     echo 'exists git'
    # else
    #     echo 'no exists git'
    # fi
}

cd $downloadPath
#遍历指定目录
## 第一级子目录下的最大的文件名称（maxFile）和大小（maxFileSize）
maxFile=$(ls -S $downloadPath | head -n 1)
tmpMaxFile=$(echo "$maxFile" | sed 's/ /_/g;s/(//g;s/)//g;s/[//g;s/]//g;s/-//g;s/{//g;s/}//g;s/（//g;s/）//g;s/【//g;s/】//g')
mv "$maxFile" "$tmpMaxFile"
maxFileSize=$(ls "$tmpMaxFile" | awk '{ print $5 }')
filePath=$tmpMaxFile

x=0
for file in $downloadPath/*; do
    if [ -d "$file" ]; then
        {
            cd "$file"
            #for file1 in $downloadPath/"$file"; do
            # ###检查.aria文件是否存在，如果存在为未下载完的文件，直接跳过
            # 不行，如果也下载在一级子目录下就会有很多问题
            # if [ -e *.aria ]; then
            #     continue
            # fi
            {
                maxFile1=$(ls -S | head -n 1)
                tmpMaxFile1=$(echo "$maxFile1" | sed 's/ /_/g')
                mv "$maxFile1" "$tmpMaxFile1"
                maxFileSize1=$(ls "$tmpMaxFile1" | awk '{ print $5 }')
                #判断二级目录下的最大的文件大小和一级目录下的最大文件到底哪个大
                if [ $maxFileSize1 -gt $maxFileSize ]; then
                    {
                        tmpMaxFile=$tmpMaxFile1
                        maxFileSize=$maxFileSize1
                        filePath=$file/$tmpMaxFile1
                    }
                fi
                # maxFile[$x]=$tmpMaxFile1
                # maxFileSize[$x]=$maxFileSize1
                # let "x+=1"
            }
            #done
        }
    fi
done
###比较一级子目录和二级子目录下的最大的文件大小是否符合设定的文件大小
if [ $maxFileSize -gt $miniSize ]; then
    {
        echo "Test pass!"
        echo -e "$filePath\n$tmpMaxFile\n$maxFileSize"
        case $fileName in
        *.mkv | *.flv | *.avi | *.rmvb | *.mpeg | *.mpg)
            ffmpeg -i $filePath -c:v copy -c:a copy $media/$tmpMaxFile.mp4
            ;;
        *)
            echo -e "未知格式!!!\n或者含有特殊字符 ?!"
            ;;
        esac
    }
fi
##清理文件
rm -rf $downloadPath/*
##获取一级子目录及二级子目录

##获取自身的名称
#    selfName=`basename $0`
#    echo $selfName;
#    x=0;
#cd ..;
#   for fileName in $downloadPath/*   #循环当前目录下的文件
#     do
#     if [ -f "$fileName" ]
#     then
#     {
#         temp=$fileName
#         temp=ls -S $downloadPath | head -n 1|sed 's/ /_/g'
#         #echo $fileName;
#         mv $fileName temp
#         array[$x]=$fileName   #文件名给数组索引为x的元素
#     }
#     let "x+=1"      #改变索引指针，步长1

#  done
# echo ${array[@]}
# echo "["$(date +%Y-%m-%d--%H:%M:%S)"]执行结束"
echo "============================================="
