## ------------------------------------------------------------
# Globals
export OSUTILS_DIR="${HOME}/AutoScripts/osUtils"
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

__SOURCING_ROOT__="${__MACOS_UTILS_DIR}"

source ${__SOURCING_ROOT__}/julia/julia.sh
source ${__SOURCING_ROOT__}/python/python.sh
source ${__SOURCING_ROOT__}/tex/tex.sh
source ${__SOURCING_ROOT__}/bash/bash.sh
source ${__SOURCING_ROOT__}/git/git.sh
source ${__SOURCING_ROOT__}/ino/ino.sh
source ${__SOURCING_ROOT__}/sys/sys.sh
source ${__SOURCING_ROOT__}/rem/rem.sh