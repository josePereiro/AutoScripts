#!/bin/bash

# TODO: add script to install .oh-my-zsh

# ---------------------------------------------------------------
# static path
INIT_PATH="${HOME}/AutoScripts/osUtils/macos/__init__.sh"

# --------------------------------------------------------------
# utils
beginswith() { case $2 in "$1"*) true;; *) false;; esac; }

# --------------------------------------------------------------
_create_config_file () {

    local file="$1"
    local sep0="# >>> osUtils entry >>>"
    local sep1="# --------------------------------------------------------------"

        local osUtils_redirect_src="\
# Redirect to osUtils if not yet done
if [ -z \"\${__ENTRY_POINT+x}\" ]; then 
    # __ENTRY_POINT is unset
    export __ENTRY_POINT=\"${file}\"
    source \"${INIT_PATH}\"
fi\
"

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
        # check file content start with osUtils_redirect_src
        if ! beginswith "${sep0}" "${content}"; then
            echo "${sep0}" > "${file}" # clear file
            echo "${osUtils_redirect_src}" >> "${file}"
            echo "" >> "${file}"
            echo "${sep1}" >> "${file}"
            echo "" >> "${file}"
            echo "${content}" >> "${file}"
        fi
    else
        echo "${sep0}" > "${file}" # clear file
        echo "${sep0}" >> "${file}"
        echo "${osUtils_redirect_src}" >> "${file}"
        echo "" >> "${file}"
        echo "${sep1}" >> "${file}"
        echo "" >> "${file}"
    fi
}

# --------------------------------------------------------------
# setup config files

_create_config_file "${HOME}/.bashrc"
_create_config_file "${HOME}/.bash_profile"
_create_config_file "${HOME}/.zshrc"
_create_config_file "${HOME}/.profile"
