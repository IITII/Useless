#!/usr/bin/env bash
##########################################
# Why we need this ?
# Take `DatabaseTools` for example:
# I am already buy another one like IDEA which bundled it.
# But I still need pay for this plugin if i want to use it in webStorm.
# So, I do this.
##########################################
# Just copy database-tool plugin
# from idea's plugin dir to webStorm's
# plugin dir
#############################################
# ~/.local/share/JetBrains/Toolbox/apps/IDEA-U/ch-0/193.6911.18/plugins/DatabaseTools
# ~/.local/share/JetBrains/Toolbox/apps/WebStorm/ch-0/193.6911.28/plugins
_FROM="IDEA-U"
_TO="WebStorm"

plugin_name="DatabaseTools"
plugin_dir="plugins"
HOME_DIR=$(cd ~/ && pwd)
APP_DIR="${HOME_DIR}/.local/share/JetBrains/Toolbox/apps"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
SKYBLUE='\033[0;36m'
PLAIN='\033[0m'
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
check_file() {
    if [[ -e $1 ]]; then
        return 0
    else
        return 1
    fi
}
not_null() {
    if [[ -z $1 ]]; then
        return 1
    else
        return 0
    fi
}
main() {
    log "Generate ${_FROM}'s plugin path..."
    FROM_DIR=${APP_DIR}/${_FROM}/ch-0/$(ls ${APP_DIR}/${_FROM}/ch-0/ | grep -Ev "plugin|vm" | tail -n 1)/${plugin_dir}/${plugin_name}
    pre_command_run_status
    log "Generate ${_TO}'s plugin path..."
    TO_DIR=${APP_DIR}/${_TO}/ch-0/$(ls ${APP_DIR}/${_TO}/ch-0/ | grep -Ev "plugin|vm" | tail -n 1)/${plugin_dir}
    pre_command_run_status
    log "Checking ${FROM_DIR} ..."
    check_file ${FROM_DIR}
    pre_command_run_status
    log "Checking ${TO_DIR} ..."
    check_file ${TO_DIR}
    pre_command_run_status
    log_info "Copying files..."
    cp -R ${FROM_DIR} ${TO_DIR}
    pre_command_run_status
    log_success "Now, restart your IDE & enable the plugin at your \"plugins\" "
}
main $@
