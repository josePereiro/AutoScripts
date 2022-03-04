__INO_DIR__="${__SOURCING_ROOT__}/ino"

alias ino_read_serial="julia --startup-file=no --project=${__INO_DIR__} -e 'import INOAssistant; INOAssistant.read_port(ARGS)' --"