__PYTHON_UTILS_DIR__="${__SOURCING_ROOT__}/python"

alias __OS_UTILS_PYTHON__="${__PYTHON_UTILS_DIR__}/.venv/bin/python"
alias __OS_UTILS_PYTHON_SOURCE_ACTIVATE__="source ${__PYTHON_UTILS_DIR__}/.venv/bin/activate"

py_activate() {
    local _to_activate="${__PYTHON_UTILS_DIR__}/_OSUTILS_PYTHON_TO_ACTIVATE_"
    local _script="${__PYTHON_UTILS_DIR__}/up_to_activate.py"
    rm -f "${_to_activate}"
    __OS_UTILS_PYTHON__ "${_script}" "$@" # Update __OSUTILS_PYTHON_TO_ACTIVATE__ file
    echo "${__OS_UTILS_PYTHON__}"
    if [ -e "${_to_activate}" ]; then
        source "${__PYTHON_UTILS_DIR__}/_OSUTILS_PYTHON_TO_ACTIVATE_"
    fi
    rm -f "${_to_activate}"
}

py_pdf2text() {
    __OS_UTILS_PYTHON__
}