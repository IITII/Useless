#!/bin/sh
CLEAN_DIR=/var/log/

# Check if user is root
[ $(id -u) != "0" ] && {
    echo "${CFAILURE}Error: You must be root to run this script${CEND}"
    exit 1
}

log() {
    echo $(date +"%H:%M:%S"): $1
}
rmArchives() {
    if [ -n "$1" ]; then
        ls . | grep -E "\.$1$" >/dev/null 2>&1
        if [ $? -eq 0 ]; then
            log "rm *.$1"
            rm *.$1
        fi
    else
        rmArchives xz
        rmArchives gz
        for i in {1..9}; do
            rmArchives $i
        done
    fi
}
traversal() {
    if [ -d $1 ]; then
        cd $1
        log "cd $(pwd)"
        log "Removing some old files..."
        rmArchives
        log "Done!!!"
        for TSName in $(ls .); do
            # Traversal Call to get All files & dir
            traversal $TSName $2
        done
        cd ..
        log "cd $(pwd)"
    elif [ -r $1 ]; then
        # pwd
        # echo $1
        log "Cleaning $1"
        echo "" >$1
        log "Next..."
    else
        log "Unable to read $1 !!!"
    fi
}
traversal $CLEAN_DIR

# Sometimes, it's not necessary about following
while getopts "f" arg; do
    case $arg in
    f)
        log "Running auto clean..."

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
        if [ "${release}" == "centos" ]; then
            yum clean
            yum autoremove
        else
            apt-get clean
            apt-get autoremove
        fi
        ;;
    esac
done
log "Finished!!!"
