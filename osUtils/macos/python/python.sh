# TODO: Document this

__PYTHON_UTILS_DIR__="${__SOURCING_ROOT__}/python"

# ENV VARIABLES
export OSUTILS_PYTHON_VENV_DEPOT="${HOME}/.python/venvs"

# Local OsUtils own python virtual enviroment, to install all required for oUtil puython tools to work...
export __OS_UTILS_PYTHON_CMD__="${__PYTHON_UTILS_DIR__}/.venv/bin/python"

# Activate an enviroment
py_activate() {
    export _OSUTILS_TO_ACTIVATE_TEMP_SCRIPT=$(mktemp -t py_activate)
    local _script="${__PYTHON_UTILS_DIR__}/up_to_activate.py"
    "${__OS_UTILS_PYTHON_CMD__}" "${_script}" "$@" # # Update bash temp script
    if [ -e "${_OSUTILS_TO_ACTIVATE_TEMP_SCRIPT}" ]; then
        source "${_OSUTILS_TO_ACTIVATE_TEMP_SCRIPT}"
    fi
    rm -f "${_OSUTILS_TO_ACTIVATE_TEMP_SCRIPT}"
}

py_exe() {
    python -c "import sys; print(sys.executable); print(sys.version)"
}

py_pdf2text() {
    local _script="${__PYTHON_UTILS_DIR__}/pdf2text.py"
    "${__OS_UTILS_PYTHON_CMD__}" "${_script}" "$@"
}

py_youtube() {
    local _script="${__PYTHON_UTILS_DIR__}/youtube.py"
    "${__OS_UTILS_PYTHON_CMD__}" "${_script}" "$@"
}

py_youtube() {
    local _script="${__PYTHON_UTILS_DIR__}/youtube.py"
    "${__OS_UTILS_PYTHON_CMD__}" "${_script}" "$@"
}

py_new_venv() {
    export _OSUTILS_TEMP_NEW_VENV_SCRIPT=$(mktemp -t py_new_venv)
    local _script="${__PYTHON_UTILS_DIR__}/create_venv.py"
    "${__OS_UTILS_PYTHON_CMD__}" "${_script}" "$@" # Update bash temp script
    if [ -e "${_OSUTILS_TEMP_NEW_VENV_SCRIPT}" ]; then
        source "${_OSUTILS_TEMP_NEW_VENV_SCRIPT}"
    fi
    rm -f "${_OSUTILS_TEMP_NEW_VENV_SCRIPT}"
}

# Desable global enviroment implicit call

mkdir "${HOME}/.local/bin"
_file="${HOME}/.local/bin/pip
echo "#! bash\necho 'No enviroment activated... see py_activate'\nexit 0%" > _file
chmod 777 _file
_file="${HOME}/.local/bin/pip3
echo "#! bash\necho 'No enviroment activated... see py_activate'\nexit 0%" > _file
chmod 777 _file
_file="${HOME}/.local/bin/python
echo "#! bash\necho 'No enviroment activated... see py_activate'\nexit 0%" > _file
chmod 777 _file
_file="${HOME}/.local/bin/python3
echo "#! bash\necho 'No enviroment activated... see py_activate'\nexit 0%" > _file
chmod 777 _file