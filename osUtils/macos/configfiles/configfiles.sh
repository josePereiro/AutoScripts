# This script will make copy of configurations files every time a shell is 
# launched. This way all of them will be in the same repo

__CONFIGFILES_DIR__="${__SOURCING_ROOT__}/configfiles"
__CONFIGFILES_BK__DIR="${__CONFIGFILES_DIR__}/bk"
mkdir -p "${__CONFIGFILES_BK__DIR}"

cp "${HOME}/.bashrc" "${__CONFIGFILES_BK__DIR}/sh.bashrc"
cp "${HOME}/.bash-profile" "${__CONFIGFILES_BK__DIR}/sh.bash-profile"
cp "${HOME}/.zshrc" "${__CONFIGFILES_BK__DIR}/sh.zshrc"
cp "${HOME}/.profile" "${__CONFIGFILES_BK__DIR}/sh.profile"

cp "${HOME}/.gitconfig" "${__CONFIGFILES_BK__DIR}/git.gitconfig"

cp "${HOME}/.julia/config/startup.jl" "${__CONFIGFILES_BK__DIR}/julia.startup.jl"

__VSCODE_USER_DIR__="${HOME}/Library/Application Support/Code/User"
cp "${__VSCODE_USER_DIR__}/keybindings.json" "${__CONFIGFILES_BK__DIR}/vscode.keybindings.json"
cp "${__VSCODE_USER_DIR__}/settings.json" "${__CONFIGFILES_BK__DIR}/vscde.settings.json"