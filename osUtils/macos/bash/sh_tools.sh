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