## ------------------------------------------------------------
# Globals
export OSUTILS_DIR="${HOME}/AutoScripts/osUtils"
export OSUTILS_CODE_WORKSPACE="${OSUTILS_DIR}/osUtils.code-workspace"
export __LINUX_UTILS_DIR="${OSUTILS_DIR}/linux"

## ------------------------------------------------------------
export __CURR_UTILS_DIR="${__LINUX_UTILS_DIR}"

## ------------------------------------------------------------
# Return if not interactive
[[ $- == *i* ]] || return

## ------------------------------------------------------------
# Welcome when interactive
echo "osUtils at '${OSUTILS_DIR}'."
echo "Use 'sys_edit_AutoScripts' for managing."
echo

## ------------------------------------------------------------
# source config files
_OSUTILS_SOURCE_CONFIG_LOCK_="LOCKED"

source "${HOME}/.bashrc"
source "${HOME}/.bash_profile"
source "${HOME}/.zshrc"
source "${HOME}/.profile"

_OSUTILS_SOURCE_CONFIG_LOCK_="UNLOCKED"

## ------------------------------------------------------------
# source osUtils

## ------------------------------------------------------------
# I use some basic stuff from the macos version
__MACOS_UTILS_DIR="${OSUTILS_DIR}/macos"

__SOURCING_ROOT__="${__MACOS_UTILS_DIR}"

source ${__SOURCING_ROOT__}/julia/julia.sh
source ${__SOURCING_ROOT__}/python/python.sh
source ${__SOURCING_ROOT__}/tex/tex.sh
source ${__SOURCING_ROOT__}/bash/bash.sh
source ${__SOURCING_ROOT__}/git/git.sh
source ${__SOURCING_ROOT__}/ino/ino.sh