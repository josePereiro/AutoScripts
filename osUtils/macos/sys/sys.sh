__SYS_DIR__="${__SOURCING_ROOT__}/sys"

## ------------------------------------------------------------
# open settings
sys_edit_AutoScripts() {
    # Try workspace first
    if [ -f ${OSUTILS_CODE_WORKSPACE} ]; then
        ${_OSUTILS_EDITOR} "${OSUTILS_CODE_WORKSPACE}"
    else
        ${_OSUTILS_EDITOR} "${OSUTILS_DIR}"
    fi
}

# source settings 
alias sys_source_config="source ${__CURR_UTILS_DIR}/__init__.sh"

# update osUtils julia utilities manifests
alias sys_up_jl_manifests="jl_update_manifests ${OSUTILS_DIR}"