#!/bin/bash
path=$3 #取原始路径，我的环境下如果是单文件则为/data/demo.png,如果是文件夹则该值为文件夹内某个文件比如/data/a/b/c/d.jpg
downloadpath='/mnt/d/迅雷下载/'  #修改成Aria2下载文件夹
# domain='moerats.com'  #修改成自己域名

if [ $2 -eq 0 ]
        then
                exit 0
fi
while true; do  #提取下载文件根路径，如把/data/a/b/c/d.jpg变成/data/a
filepath=$path
path=${path%/*}; 
if [ "$path" = "$downloadpath" ] && [ $2 -eq 1 ]  #如果下载的是单个文件
    then
    #获取视频文件名称
    name=`ls`
    filename=`ls|grep -E '*.mp4|*.mkv|*.flv|*.avi|*.rmvb|*.mpeg|*.mpg'`
    #判断非空
    if [ ! -z "$filename" ]
        then
        echo "下载的文件为受支持的格式，文件名称为: $filename"
        echo "转码开始..."
        #ffmpeg -i $filename -c copy -f mp4 $filename.mp4
        else
        echo "下载的文件为不受支持的格式，文件名称为: $name"
    fi

    # php /www/wwwroot/$domain/one.php upload:file $filepath /$folder/
    ## rm -rf $filepath
    # php /www/wwwroot/$domain/one.php cache:refresh
    # exit 0
#elif [ "$path" = "$downloadpath" ]
#    then
#    php /www/wwwroot/$domain/one.php upload:folder $filepath /$folder/
#    rm -rf "$filepath/"
 #   php /www/wwwroot/$domain/one.php cache:refresh
    #exit 0
fi
done
# Add to aria2.conf
# on-download-complete=/root/.aria2/oneindexup.sh
# echo "on-download-complete=/root/.aria2/oneindexup.sh" >> /root/.aria2/aria2.conf