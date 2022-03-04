#!/bin/bash

# TODO: add script to install .oh-my-zsh

# ---------------------------------------------------------------
# static path
INIT_PATH="${HOME}/AutoScripts/osUtils/linux/__init__.sh"

# --------------------------------------------------------------
# utils
beginswith() { case $2 in "$1"*) true;; *) false;; esac; }

# --------------------------------------------------------------
_create_config_file () {

    local file="$1"
    local sep="

# --------------------------------------------------------------
    "

    local osUtils_redirect_str="\
# --------------------------------------------------------------
# Redirect to osUtils if not yet done
if [ \"\${_OSUTILS_SOURCE_CONFIG_LOCK_}\" != \"LOCKED\" ] && [ -f ${INIT_PATH} ]; then
    source ${INIT_PATH}
    return 0
fi"

    # backup
    local filebk="${file}bk"
    local bkfound="NO"
    while [ -f ${filebk} ]; do
        if cmp -bs ${file} ${filebk} ; then
            local bkfound="YES"
        fi
        local filebk="${filebk}bk"
    done
    if [ -f ${file} ] && [ "${bkfound}" = "NO" ]; then
        cat "${file}" > "${filebk}"
    fi

    # overwrite config file
    if [ -f ${file} ]; then
        local content=`cat ${file}`
        # check file content start with osUtils_redirect_str
        if ! beginswith "${osUtils_redirect_str}" "${content}"; then
            echo "${osUtils_redirect_str}${sep}${content}"  > "${file}"
        fi
    else
        echo "${osUtils_redirect_str}${sep}" > "${file}"
    fi
}

# --------------------------------------------------------------
# setup config files

_create_config_file "${HOME}/.bashrc"
_create_config_file "${HOME}/.bash_profile"
_create_config_file "${HOME}/.zshrc"
_create_config_file "${HOME}/.profile"
