# search for a 'pyvenv.cfg' and create a bash script to source it...
# %% - - - - - - - - - - - - - - - - - - - - - - - - - - 
import argparse
import os
from utils import *

# %% - - - - - - - - - - - - - - - - - - - - - - - - - - 
def main():
    # CLI
    # TODO: add verbose
    parser = argparse.ArgumentParser(description="Generate a new virtual env at ~/.python/venvs")
    parser.add_argument(
        '--name', "-n",
        default = "",
        help='venv parent folder name', 
    )
    parser.add_argument(
        '--py', "-p",
        default = "default",
        help='parent python env (it needs to be a path to the executable)', 
    )
    parser.add_argument(
        '--dry', '-d', 
        action='store_true', 
        help='Enable verbose mode'
    )
    args = parser.parse_args()

    # extract args
    name = args.name
    dry_run = args.dry
    python = args.py

    print(f"cli_name: {name}")
    print(f"dry_run: {dry_run}")

    # To sync with bash caller
    sh_script_file = os.environ.get("_OSUTILS_TEMP_NEW_VENV_SCRIPT", None)
    if not sh_script_file: return 0
    depot_dir = os.environ.get("OSUTILS_PYTHON_VENV_DEPOT", None)
    if not depot_dir: return 0
    if python == "default":
        python = os.environ.get("__OS_UTILS_PYTHON_CMD__", None)
    if not python: return 0
    if not os.path.isfile(python): 
        print(f"OsUtils python env not found... You need to set up one at: {python}")

    open(sh_script_file, "w").write(
        f"mkdir -p '{depot_dir}'; cd {depot_dir}; {python} -m venv '{name}'"
    )
    return 0

if __name__ == "__main__":
    main()
