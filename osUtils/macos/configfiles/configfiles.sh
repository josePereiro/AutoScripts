# This script will make copy of configurations files every time a shell is 
# launched. This way all of them will be in the same repo

__CONFIGFILES_DIR__="${__SOURCING_ROOT__}/configfiles"
__CONFIGFILES_BK__DIR="${__CONFIGFILES_DIR__}/bk"
mkdir -p "${__CONFIGFILES_BK__DIR}"

cp "${HOME}/.bashrc" "${__CONFIGFILES_BK__DIR}/sh.bashrc-$(date -I)"
cp "${HOME}/.bash-profile" "${__CONFIGFILES_BK__DIR}/sh.bash-profile-$(date -I)"
cp "${HOME}/.zshrc" "${__CONFIGFILES_BK__DIR}/sh.zshrc-$(date -I)"
cp "${HOME}/.profile" "${__CONFIGFILES_BK__DIR}/sh.profile-$(date -I)"

cp "${HOME}/.gitconfig" "${__CONFIGFILES_BK__DIR}/git.gitconfig-$(date -I)"

cp "${HOME}/.julia/config/startup.jl" "${__CONFIGFILES_BK__DIR}/julia.startup.jl-$(date -I)"

__VSCODE_USER_DIR__="${HOME}/Library/Application Support/Code/User"
cp "${__VSCODE_USER_DIR__}/keybindings.json" "${__CONFIGFILES_BK__DIR}/vscode.keybindings.json-$(date -I)"
cp "${__VSCODE_USER_DIR__}/settings.json" "${__CONFIGFILES_BK__DIR}/vscde.settings.json-$(date -I)"