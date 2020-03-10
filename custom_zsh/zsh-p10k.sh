#!/bin/bash
export PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin

release="ubuntu"
# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
SKYBLUE='\033[0;36m'
PLAIN='\033[0m'

check_root() {
    [[ $(id -u) != "0" ]] && {
        log "Error: You must be root to run this script"
        exit 1
    }
}
log() {
    echo -e "[$(/bin/date)] $1"
}
log_success() {
    echo -e "${GREEN}[$(/bin/date)] $1${PLAIN}"
}
log_info() {
    echo -e "${YELLOW}[$(/bin/date)] $1${PLAIN}"
}
log_prompt() {
    echo -e "${SKYBLUE}[$(/bin/date)] $1${PLAIN}"
}
log_err() {
    echo -e "${RED}[$(/bin/date)] $1${PLAIN}"
}
pre_command_run_status() {
    if [[ $? -eq 0 ]]; then
        log_success "Success"
    else
        log_err "Failed"
        exit 1
    fi
}
check_release() {
    if [[ -f /etc/redhat-release ]]; then
        release="centos"
    elif cat /etc/issue | grep -Eqi "debian"; then
        release="debian"
    elif cat /etc/issue | grep -Eqi "ubuntu"; then
        release="ubuntu"
    elif cat /etc/issue | grep -Eqi "centos|red hat|redhat"; then
        release="centos"
    elif cat /etc/issue | grep -Eqi "alpine"; then
        release="alpine"
    elif cat /proc/version | grep -Eqi "debian"; then
        release="debian"
    elif cat /proc/version | grep -Eqi "ubuntu"; then
        release="ubuntu"
    elif cat /proc/version | grep -Eqi "centos|red hat|redhat"; then
        release="centos"
    fi
}
check_command() {
    if ! command -v $2 >/dev/null 2>&1; then
        log "Installing $2 from $1 repo"
        if [[ "$1" = "centos" ]]; then
            yum update >/dev/null 2>&1
            yum -y install $3 >/dev/null 2>&1
        elif [[ "$1" = "alpine" ]]; then
            apk update >/dev/null 2>&1
            apk --no-cache add $3 >/dev/null 2>&1
        else
            apt-get update >/dev/null 2>&1
            apt-get install $3 -y >/dev/null 2>&1
        fi
        pre_command_run_status
    fi
}
main() {
    HOME=$(cd ~/ && pwd)
    ZSH_HOME=${HOME}/.oh-my-zsh
    ZSH_CUSTOM=${ZSH_HOME}/custom
    check_release
    check_command ${release} zsh zsh
    check_command ${release} wget wget
    check_command ${release} sed sed
    check_command ${release} curl curl
    check_command ${release} whoami coreutils
    if [ -d ${ZSH_HOME} ]; then
        log_success "Oh-my-zsh is already installed"
    else
        log_info "Installing oh-my-zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        pre_command_run_status
    fi
    log_info "Downloading theme"
    if [ -d ${ZSH_CUSTOM}/themes/powerlevel10k ]; then
        log_success "Theme powerlevel10k is already installed"
    else
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM}/themes/powerlevel10k
        pre_command_run_status
    fi
    log_info "Downloading oh-my-zsh config"
    wget -N -q --no-check-certificate -O ~/.zshrc \
        https://raw.githubusercontent.com/IITII/Useless/master/custom_zsh/zshrc
    pre_command_run_status
    log_info "Downloading theme config"
    log_prompt "For more: see -> https://github.com/romkatv/powerlevel10k"
    wget -N -q --no-check-certificate -O ~/.p10k.zsh \
        https://raw.githubusercontent.com/IITII/Useless/master/custom_zsh/p10k.zsh
    pre_command_run_status
    log_info "Modify config..."
    sed -i "s|^export ZSH=\"/root/.oh-my-zsh\"$|export ZSH=\"${ZSH_HOME}\"|g" ${HOME}/.zshrc
    #sed -i "s/^export ZSH=\"\/root\/.oh-my-zsh\"$/export ZSH=\"\/$(whoami)\/.oh-my-zsh\"/g" ~/.zshrc
    pre_command_run_status
    #log_info "Reloading zsh..."
    #source ~/.zshrc
    #pre_command_run_status
    log_prompt "Almost done..."
    log_prompt "Please COPY & PASTE following...\n\nsource ~/.zshrc"
    #log_success "source ~/.zshrc"
}
main
