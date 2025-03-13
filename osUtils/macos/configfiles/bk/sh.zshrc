# >>> osUtils entry >>>
# Redirect to osUtils if not yet done
if [ -z "${__ENTRY_POINT+x}" ]; then 
    # __ENTRY_POINT is unset
    __ENTRY_POINT="/Users/Pereiro/.zshrc"
    source "/Users/Pereiro/AutoScripts/osUtils/macos/__init__.sh"
fi

# --------------------------------------------------------------



export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
