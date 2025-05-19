## ------------------------------------------------------------
# Globals
export OSUTILS_DIR="${HOME}/AutoScripts/osUtils"
export OSUTILS_CODE_WORKSPACE="${OSUTILS_DIR}/osUtils.code-workspace"
export __MACOS_UTILS_DIR="${HOME}/AutoScripts/osUtils/macos"

## ------------------------------------------------------------
export __CURR_UTILS_DIR="${__MACOS_UTILS_DIR}"

## ------------------------------------------------------------
# Return if not interactive
[[ $- == *i* ]] || return

## ------------------------------------------------------------
# Welcome when interactive
echo "osUtils at '${OSUTILS_DIR}'."
echo "Use 'sys_edit_AutoScripts' for managing."
echo "entry file ${__ENTRY_POINT}"
echo

## ------------------------------------------------------------
# source osUtils

__SOURCING_ROOT__="${__MACOS_UTILS_DIR}"

source ${__SOURCING_ROOT__}/julia/julia.sh
source ${__SOURCING_ROOT__}/python/python.sh
source ${__SOURCING_ROOT__}/tex/tex.sh
source ${__SOURCING_ROOT__}/bash/bash.sh
source ${__SOURCING_ROOT__}/git/git.sh
source ${__SOURCING_ROOT__}/ino/ino.sh
source ${__SOURCING_ROOT__}/sys/sys.sh
source ${__SOURCING_ROOT__}/oba/oba.sh
source ${__SOURCING_ROOT__}/js/js.sh
source ${__SOURCING_ROOT__}/configfiles/configfiles.sh 

## ------------------------------------------------------------
# source config files

time source "${HOME}/.bashrc"
time source "${HOME}/.bash_profile"
time source "${HOME}/.zshrc"
time source "${HOME}/.profile"

# ## ------------------------------------------------------------
# onfinish hook
time source ${__SOURCING_ROOT__}/onfinish/onfinish.sh 