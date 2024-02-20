# search for a 'pyvenv.cfg' and create a bash script to source it...
# %% - - - - - - - - - - - - - - - - - - - - - - - - - - 
import argparse
import os
from utils import *

def check_for_venv(root, name0, trigger_files):
    if name0 and name0 != os.path.basename(root): return False
    for trigger in trigger_files:
        file = os.path.join(root, trigger)
        if os.path.isfile(file): return True
    return False
    

def up_activate(
        root0, name0, trigger_files, 
        to_activate_file, slevel, verbose, 
        dry_run
    ):
    root0 = os.path.expanduser(root0)
    root0 = os.path.abspath(root0)
    if not os.path.isdir(root0): return False
    if verbose: print("---------------------")
    if verbose: print("root0", root0)

    _len_root0 = root0.count(os.path.sep)
    for root, dirs, files in os.walk(root0):
        root = os.path.abspath(root)
        
        # check level
        _len_root = root.count(os.path.sep)
        if (_len_root - _len_root0) >= slevel: continue

        if verbose: print("root", root)

        # check for venv
        if not check_for_venv(root, name0, trigger_files): continue
        activate_file = os.path.join(root, "bin", "activate")
        
        # up to_activate
        if not dry_run: 
            open(to_activate_file, "w").write(
                f"source '{activate_file}'"
            )

        print(f"venv found: {root}")
        print(f"activate_file: {activate_file}")
        
        return True
    return False

# %% - - - - - - - - - - - - - - - - - - - - - - - - - - 
def main():
    # CLI
    # TODO: add verbose
    parser = argparse.ArgumentParser(description="Read a pdf and creates a txt file!")
    parser.add_argument(
        '--name', "-n",
        default = "",
        help='venv parent folder name', 
    )
    parser.add_argument(
        '--level', "-l",
        default = 3,
        help='search depth level', 
        type = int
    )
    parser.add_argument(
        '--verbose', '-v', 
        action='store_true', 
        help='Enable verbose mode'
    )
    parser.add_argument(
        '--dry', '-d', 
        action='store_false', 
        help='Enable verbose mode'
    )
    args = parser.parse_args()

    # extract args
    name = args.name
    slevel = args.level
    verbose = args.verbose
    dry_run = args.verbose

    print(f"cli_name: {name}")
    print(f"cli_slevel: {slevel}")
    print(f"cli_verbose: {verbose}")
    print(f"dry_run: {dry_run}")

    # To sync with bash caller
    to_activate_file = os.environ.get("_OSUTILS_TO_ACTIVATE_FILE", None)
    if not to_activate_file: return 0

    # resolve roots
    roots = []
    roots.append(os.getcwd())
    envs_paths = os.environ.get("OSUTILS_VENV_PATH", None)
    if envs_paths:
        envs_paths = envs_paths.split(";") 
        roots.extend(envs_paths)
    
    # trigger_files
    trigger_files = ["pyvenv.cfg"]

    for root0 in roots:
        flag = up_activate(
            root0, name, trigger_files, to_activate_file, 
            slevel, verbose, dry_run
        )
        if flag: return 0

    return 0

if __name__ == "__main__":
    main()
