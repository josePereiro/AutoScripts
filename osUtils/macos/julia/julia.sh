## ------------------------------------------------------------
# env variables
# see .bashrc

## ------------------------------------------------------------
# utils
# Open .julia/config/startup.jl
alias jl_edit_startup="code -r /Users/Pereiro/.julia/config/startup.jl"

alias lijulia='julia --startup-file=no -O2'
alias juliap='julia --project'

# go .julia/dev
alias jl_cd_dev="cd /Users/Pereiro/.julia/dev"

alias jl_run_deamon_server='julia --startup-file=no -e "using DaemonMode; serve()" &'
alias jl_deamon='julia --startup-file=no -e "using DaemonMode; runargs()" -- '

__JULIA_UTILS_DIR__="${__SOURCING_ROOT__}/julia"

# JLAssistant
alias jl_create_pkg_version="julia --startup-file=no --project=${__JULIA_UTILS_DIR__} -e 'import JLAssistant; JLAssistant.run_create_pkg_version(ARGS)' --"
alias jl_commit_to_registry="julia --startup-file=no --project=${__JULIA_UTILS_DIR__} -e 'import JLAssistant; JLAssistant.run_commit_to_registry(ARGS)' --"
alias jl_generate_pkg="julia --startup-file=no --project=${__JULIA_UTILS_DIR__} -e 'import JLAssistant; JLAssistant.run_generate_pkg(ARGS)' --"
alias jl_import_pkgs="julia --startup-file=no --project=${__JULIA_UTILS_DIR__} -e 'import JLAssistant; JLAssistant.run_import_pkgs(ARGS)' --"
alias jl_precompile_projects="julia --startup-file=no --project=${__JULIA_UTILS_DIR__} -e 'import JLAssistant; JLAssistant.run_precompile_projects(ARGS)' --"
alias jl_update_manifests="julia --startup-file=no --project=${__JULIA_UTILS_DIR__} -e 'import JLAssistant; JLAssistant.run_update_manifests(ARGS)' --"
alias jl_upgrade_manifests="julia --startup-file=no --project=${__JULIA_UTILS_DIR__} -e 'import JLAssistant; JLAssistant.run_upgrade_manifests(ARGS)' --"
alias jl_redo_include_block="julia --startup-file=no --project=${__JULIA_UTILS_DIR__} -e 'import JLAssistant; JLAssistant.run_redo_include_block(ARGS)' --"
alias jl_check_imports="julia --startup-file=no --project=${__JULIA_UTILS_DIR__} -e 'import JLAssistant; JLAssistant.run_check_imports(ARGS)' --"
alias jl_script="julia --startup-file=no --project=${__JULIA_UTILS_DIR__} -e 'import JLAssistant; JLAssistant.run_jl_script(ARGS)' --"
alias jl_open_workspace="julia --startup-file=no --project=${__JULIA_UTILS_DIR__} -e 'import JLAssistant; JLAssistant.run_open_devpath_workspace(ARGS)' --"
alias jl_show_workspaces="julia --startup-file=no --project=${__JULIA_UTILS_DIR__} -e 'import JLAssistant; JLAssistant._show_dev_workspaces()' --"

# PkgMassInstaller
alias jl_mass_installer="julia --startup-file=no --project=${__JULIA_UTILS_DIR__} -e 'import PkgMassInstaller; PkgMassInstaller.install_projs_args()' --"

# osUtils scripts
alias jl_pluto="julia --startup-file=no ${__JULIA_UTILS_DIR__}/jl_pluto.jl"
alias jl_code_pkg="julia --startup-file=no --project=${__JULIA_UTILS_DIR__} ${__JULIA_UTILS_DIR__}/jl_code_pkg.jl"
alias jl_test_internet="julia --startup-file=no --project=${__JULIA_UTILS_DIR__} ${__JULIA_UTILS_DIR__}/jl_test_internet.jl"
alias jl_add_pkg="julia --startup-file=no --project ${__JULIA_UTILS_DIR__}/jl_add_pkg.jl"

# Pkg stuff
alias jl_test_pkg='julia --startup-file=no --project -e "import Pkg; Pkg.test()" 2>&1'
alias jl_resolve_pkg='julia --startup-file=no --project -e "import Pkg; Pkg.resolve()" 2>&1'
alias jl_build_pkg='julia --startup-file=no --project -e "import Pkg; Pkg.build()" 2>&1'
alias jl_precompile_pkg='julia --startup-file=no --project -e "import Pkg; Pkg.precompile()" 2>&1'
