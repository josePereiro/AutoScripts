# >>> osUtils entry >>>
# Redirect to osUtils if not yet done
if [ -z "${__ENTRY_POINT+x}" ]; then 
    # __ENTRY_POINT is unset
    __ENTRY_POINT="/Users/Pereiro/.bashrc"
    source "/Users/Pereiro/AutoScripts/osUtils/macos/__init__.sh"
fi

# --------------------------------------------------------------
# MARK: Proxy settings
# UH
declare -a PROXY_POOL
PROXY_POOL[1]="http://apereiro%40fbio.uh.cu:92110927807@proxy-trab.uh.cu:3128/"

## ------------------------------------------------------------
# MARK: gurobi
export GRB_LICENSE_FILE=/Users/Pereiro/Documents/gurobi.lic

## ------------------------------------------------------------
# MARK: MATLAB
export MATLAB_HOME=/Applications/MATLAB_R2017a.app

## ------------------------------------------------------------
# MARK: Marker
MARKER_PDF_LOCAL_REPO[1]="/Users/Pereiro/Desktop/reading"
MARKER_PDF_REMOTES[1]="pereiro@10.6.230.13:/home/pereiro/reading"

MARKER_MARKDOWN_REMOTES[1]="pereiro@10.6.230.13:/home/pereiro/marker"
MARKER_MARKDOWN_LOCAL_REPO[1]="/Users/Pereiro/marker"

## ------------------------------------------------------------
# MARK: JAVA
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
export JULIA_NUM_THREADS=4
export JULIA_EDITOR="code"
export JULIA_MAX_NUM_PRECOMPILE_FILES=2
export JULIA_PKG_PRESERVE_TIERED_INSTALLED=1
export JULIA_PKG_PRECOMPILE_AUTO=0
export JULIA_PKG_OFFLINE=1

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
