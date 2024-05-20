__TEX_DIR__="${__SOURCING_ROOT__}/tex"

alias tex_clear_support_files="julia --startup-file=no --project=${__TEX_DIR__} ${__TEX_DIR__}/tex_clear_support_files.jl"
alias tex_expand_project="julia --startup-file=no --project=${__TEX_DIR__} ${__TEX_DIR__}/tex_expand_project.jl"
alias tex_extract_sec_to_files="julia --startup-file=no --project=${__TEX_DIR__} ${__TEX_DIR__}/tex_extract_sec_to_files.jl"
alias tex_increment_fileid="julia --startup-file=no --project=${__TEX_DIR__} ${__TEX_DIR__}/tex_increment_fileid.jl"
alias tex_open_glob_bib='code -r ~/Documents/My\ Library.bib'
alias tex_to_clipboard="julia --startup-file=no --project=${__TEX_DIR__} ${__TEX_DIR__}/tex_to_clipboard.jl"
alias tex_generate="julia --startup-file=no --project=${__TEX_DIR__} ${__TEX_DIR__}/tex_generate.jl"

# TexAssistant
alias tex_import_ref="julia --startup-file=no --project=${__TEX_DIR__} -e 'import TexAssistant; TexAssistant._import_ref_cli(ARGS)' --"