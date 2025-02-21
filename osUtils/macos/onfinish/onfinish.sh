__ONFINISHED_UTILS_DIR__="${__SOURCING_ROOT__}/onfinish"

## ------------------------------------------------------------
# Return if not interactive
[[ $- == *i* ]] || return

## ------------------------------------------------------------
# run git auto commit
echo "${__ONFINISHED_UTILS_DIR__}"
bash "${__ONFINISHED_UTILS_DIR__}/auto-commit.sh" > /dev/null 2>&1
# bash "${__ONFINISHED_UTILS_DIR__}/auto-commit.sh"