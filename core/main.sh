# Prevent sourcing multiple times
if [[ -n "${AUTOSCRIPTS_CORE_MAIN_SH_SOURCED}" ]]; then
    return
fi
export AUTOSCRIPTS_CORE_MAIN_SH_SOURCED=1
## .- . -. -. .. . . .- - - -- -. -. - - -. - -.

# This is the entry point to AutoScripts
#   - a common place for all system-wise cli tools
#   - tools about everything and integrated in the same way

## .- . -. -. .. . . .- - - -- -. -. - - -. - -.
# globals 
export AUTOSCRIPTS_ROOT_FOLDER="${HOME}/AutoScripts"
export AUTOSCRIPTS_CORE_FOLDER="${AUTOSCRIPTS_ROOT_FOLDER}/core"
export AUTOSCRIPTS_MACOS_HOME_FOLDER="${AUTOSCRIPTS_ROOT_FOLDER}/macos"
export AUTOSCRIPTS_LINUX_HOME_FOLDER="${AUTOSCRIPTS_ROOT_FOLDER}/linux"

# TODO: create a user interface for this value
# This should be configurable
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS specific code
    export AUTOSCRIPTS_TOOLS_HOME_FOLDER="${AUTOSCRIPTS_MACOS_HOME_FOLDER}"
elif [[ "$OSTYPE" == "linux"* ]]; then
    # Linux specific code
    export AUTOSCRIPTS_TOOLS_HOME_FOLDER="${AUTOSCRIPTS_LINUX_HOME_FOLDER}"
else
    echo "unsupported os"
    exit 1
fi

## .- . -. -. .. . . .- - - -- -. -. - - -. - -.
# Utils 
source "${AUTOSCRIPTS_CORE_FOLDER}/utils.sh"

## .- . -. -. .. . . .- - - -- -. -. - - -. - -.
# MARK: subsystems 
source_if_exists "${AUTOSCRIPTS_TOOLS_HOME_FOLDER}/julia/julia.sh"