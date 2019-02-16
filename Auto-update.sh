#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
#date: Fri Feb 15 21:16:06 CST 2019
#####define
work_dir="/www/wwwroot/list.ccatk.tw/Download" ##工作目录

##下面的一般不需要修改
repo="erguotou520/electron-ssr" ##github repo及用户名称
repo_name="electron-ssr" #github repo名称

version=""  #版本号
platform="AppImage deb exe" #后缀名


Update(){
##获取当前版本号
##wget --no-check-certificate -qO- https://api.github.com/repos/$repo/releases | grep -o '"tag_name": ".*"' |head -n 1| sed 's/"//g;s/v//g' | sed 's/tag_name: //g'
version=`wget --no-check-certificate -qO- https://api.github.com/repos/$repo/releases | grep -o '"tag_name": ".*"' |head -n 1| sed 's/"//g;s/v//g' | sed 's/tag_name: //g'`

##查看是否已下载和已下载版本号是否符合
ls | grep electron-ssr | grep $version
a=$? ## 获取 ls 命令的结果
##判断版本号 & 下载
if [ $a -eq 0 ]
    then
    echo -e "$repo_name was already up to date!! \nSkipped!! \n "
    #exit 0;   
else
    for seleted in $platform
    do
    #wget --no-check-certificate  https://github.com/$repo/releases/download/v$version/$repo_name-$version.$seleted
    wget --no-check-certificate -q https://github.com/$repo/releases/download/v$version/$repo_name-$version.$seleted
    echo -e "Updated $repo_name-*.$seleted to $repo_name-$version.$seleted"
    done
    echo -e "\nUpdate Finished! \n"
    
fi
}

#进入工作目录
cd $work_dir

echo -e "\nDate: `date` \n"
## run function Update()
Update

# logs 
echo "---------------------------------------------------------------------"

exit 0;
#https://github.com/erguotou520/electron-ssr/releases/download/v0.2.6/electron-ssr-0.2.6.AppImage
#https://github.com/erguotou520/electron-ssr/releases/download/v0.2.6/electron-ssr-0.2.6.deb
#https://github.com/erguotou520/electron-ssr/releases/download/v0.2.6/electron-ssr-0.2.6.exe
