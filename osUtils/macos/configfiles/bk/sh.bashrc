# >>> osUtils entry >>>
# Redirect to osUtils if not yet done
if [ -z "${__ENTRY_POINT+x}" ]; then 
    # __ENTRY_POINT is unset
    export __ENTRY_POINT="/Users/Pereiro/.bashrc"
    source "/Users/Pereiro/AutoScripts/osUtils/macos/__init__.sh"
fi

# --------------------------------------------------------------
# Proxy settings
# UH
PROXY_POOL[1]="http://apereiro%40fbio.uh.cu:92110927807@proxy-trab.uh.cu:3128/"
PROXY_POOL[2]="http://gsierra%40estudiantes.fbio.uh.cu:Realmadrid123***@proxy-est.uh.cu:3128/"
PROXY_POOL[3]="http://barbara.perezf%40fisica.uh.cu:Enaira.1995@proxy-trab.uh.cu:3128/"

# ETECSA
PROXY_POOL[4]="http://fisica:physicsa@10.6.230.13:58132/"

# JUAN's HOME
PROXY_POOL[5]="http://proxy.enet.cu:1080/"

# Programs Settings
## ------------------------------------------------------------
# gurobi
export GRB_LICENSE_FILE=/Users/Pereiro/Documents/gurobi.lic

## ------------------------------------------------------------
# MATLAB
export MATLAB_HOME=/Applications/MATLAB_R2017a.app

## ------------------------------------------------------------
# JAVA
# export JAVA_HOME=`/usr/libexec/java_home -v 1.8.0_191`

## ------------------------------------------------------------
# # C
# export LIBRARY_PATH=/usr/local/lib
# export C_INCLUDE_PATH=/usr/local/include
# export LD_LIBRARY_PATH=/usr/local/lib
# CC="clang"
# CFLAGS="-ferror-limit=1 -gdwarf-4 -ggdb3 -O0 -std=c11 -Wall -Werror -Wextra -Wno-gnu-folding-constant -Wno-sign-compare -Wno-unused-parameter -Wno-unused-variable -Wno-unused-but-set-variable -Wshadow"
# LDLIBS="-lcrypt -lcs50 -lm"

## ------------------------------------------------------------
# python

# semicolon separated [path1;path2...]
export OSUTILS_PYTHON_VENV_PATH="${HOME}/.python/venvs/global;${OSUTILS_PYTHON_VENV_DEPOT}"

## ------------------------------------------------------------
# TexAssitant
export GLOBAL_BIB_LIBRARY="${HOME}/Documents/My Library.bib"

# --------------------------------------------------------------
# OpenSCAD

# --------------------------------------------------------------
# ZSH
# autosuggestions
source "$ZSH/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"

# --------------------------------------------------------------
# Julia
export JULIA_MAX_NUM_PRECOMPILE_FILES=1
export JULIA_PKG_PRECOMPILE_AUTO=0

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

case ":$PATH:" in
    *:/Users/Pereiro/.juliaup/bin:*)
        ;;

    *)
        export PATH=/Users/Pereiro/.juliaup/bin${PATH:+:${PATH}}
        ;;
esac

# <<< juliaup initialize <<<
