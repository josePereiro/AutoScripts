__PYTHON_UTILS_DIR__="${__SOURCING_ROOT__}/python"

alias __OS_UTILS_PYTHON__="${__PYTHON_UTILS_DIR__}/.venv/bin/python"
alias __OS_UTILS_PYTHON_SOURCE_ACTIVATE__="source ${__PYTHON_UTILS_DIR__}/.venv/bin/activate"

py_activate() {
    export _OSUTILS_TO_ACTIVATE_FILE=$(mktemp -t py_activate)
    local _script="${__PYTHON_UTILS_DIR__}/up_to_activate.py"
    __OS_UTILS_PYTHON__ "${_script}" "$@" # Update __OSUTILS_PYTHON_TO_ACTIVATE__ file
    if [ -e "${_OSUTILS_TO_ACTIVATE_FILE}" ]; then
        source "${_OSUTILS_TO_ACTIVATE_FILE}"
    fi
    rm -f "${_OSUTILS_TO_ACTIVATE_FILE}"
}

py_exe() {
    python -c "import sys; print(sys.executable)"
}

py_pdf2text() {
    local _script="${__PYTHON_UTILS_DIR__}/pdf2text.py"
    __OS_UTILS_PYTHON__ "${_script}" "$@"
}