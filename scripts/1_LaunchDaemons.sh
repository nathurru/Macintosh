#!/bin/bash

GLOBAL_DAEMON_DIR=/Library/LaunchDaemons
GLOBAL_AGENT_DIR=/Library/LaunchAgents
USER_AGENT_DIR=~/Library/LaunchAgents
SCRIPT_DIR=$(cd $(dirname $0); pwd)
LAUNCHD_DIR=$(cd ${SCRIPT_DIR}/../launchds; pwd)

for file in `\find ${LAUNCHD_DIR}/globalDaemons -maxdepth 1 -name '*.plist'`; do
    DST_FILE=${GLOBAL_DAEMON_DIR}/$(basename ${file})
    printf "Setting ${DST_FILE}..."
    if [ -e  ${DST_FILE} ]; then
        printf "\e[33mEXISTS\e[m\n"
    else
        sudo cp ${file} ${GLOBAL_DAEMON_DIR}
        sudo chmod 644 ${DST_FILE}
        sudo chown root:wheel ${DST_FILE}
        sudo launchctl load ${DST_FILE}
        printf "\e[32mDONE\e[m\n"
    fi
done

for file in `\find ${LAUNCHD_DIR}/globalAgents -maxdepth 1 -name '*.plist'`; do
    DST_FILE=${GLOBAL_AGENT_DIR}/$(basename ${file})
    printf "Setting ${DST_FILE}..."
    if [ -e  ${DST_FILE} ]; then
        printf "\e[33mEXISTS\e[m\n"
    else
        sudo cp ${file} ${GLOBAL_AGENT_DIR}
        sudo chmod 644 ${DST_FILE}
        sudo chown root:wheel ${DST_FILE}
        sudo launchctl load ${DST_FILE}
        printf "\e[32mDONE\e[m\n"
    fi
done

for file in `\find ${LAUNCHD_DIR}/userAgents -maxdepth 1 -name '*.plist'`; do
    DST_FILE=${USER_AGENT_DIR}/$(basename ${file})
    printf "Setting ${DST_FILE}..."
    if [ -e  ${DST_FILE} ]; then
        printf "\e[33mEXISTS\e[m\n"
    else
        cp ${file} ${USER_AGENT_DIR}
        chmod 644 ${DST_FILE}
        launchctl load ${DST_FILE}
        printf "\e[32mDONE\e[m\n"
    fi
done
