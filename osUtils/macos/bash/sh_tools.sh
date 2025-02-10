# internet
sh_tcp_listening() {
    if [ $# -eq 0 ]; then
        sudo lsof -iTCP -sTCP:LISTEN -n -P
    elif [ $# -eq 1 ]; then
        sudo lsof -iTCP -sTCP:LISTEN -n -P | grep -i --color $1
    else
        echo "Usage: listening [pattern]"
    fi
}

## ------------------------------------------------------------
_OSUTILS_EDITOR=code

_sh_open_in_editor() {
    local file="$1"
    [ -f "${file}" ] && ${_OSUTILS_EDITOR} ${file}
}

sh_open_sys_config() {
    _sh_open_in_editor "${HOME}/.bashrc"
    _sh_open_in_editor "${HOME}/.bash_profile"
    _sh_open_in_editor "${HOME}/.zshrc"
    _sh_open_in_editor "${HOME}/.profile"
}

## ------------------------------------------------------------
# create virtual link for config file
# For use inside vscode

_link_config() {
    if [[ ! -f "${__BASH_UTILS_DIR__}/config/$1" ]]
    then
        if [[ -f "${HOME}/$1" ]] 
        then
            mkdir -p "${__BASH_UTILS_DIR__}/config"
            ln -s "${HOME}/$1" "${__BASH_UTILS_DIR__}/config/$1"
        fi
    fi
}
_link_config ".bashrc"
_link_config ".bash_profile"
_link_config ".zshrc"
_link_config ".profile"