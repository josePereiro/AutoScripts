__OBA_DIR__="${__SOURCING_ROOT__}/oba"

alias oba_extract_vault="julia --startup-file=no --project=${__OBA_DIR__} -e 'import ObsidianAssistant; ObsidianAssistant.extract_vault_cli(ARGS)' --"