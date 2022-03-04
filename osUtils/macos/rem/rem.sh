## ------------------------------------------------------------
__REM_UTILS_DIR__="${__SOURCING_ROOT__}/rem"

# RemAssistant
alias rem_assistant="julia -i --startup-file=no --project=${__REM_UTILS_DIR__} -e 'using RemAssistant' --"
alias rem_copy_bibref="julia --startup-file=no --project=${__REM_UTILS_DIR__} -e 'import RemAssistant; RemAssistant.copy_bibref(ARGS)' --"
alias rem_filter_bibref="julia --startup-file=no --project=${__REM_UTILS_DIR__} -e 'import RemAssistant; RemAssistant.filter_bibref(ARGS)' --"
