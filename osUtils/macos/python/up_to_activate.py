# search for a 'pyvenv.cfg' and create a bash script to source it...
# %% - - - - - - - - - - - - - - - - - - - - - - - - - - 
import argparse
import os
from utils import *

# %% - - - - - - - - - - - - - - - - - - - - - - - - - - 
def check_for_venv(root, name0, trigger_files):
    if name0 and name0 != os.path.basename(root): return False
    for trigger in trigger_files:
        file = os.path.join(root, trigger)
        if os.path.isfile(file): return True
    return False

# %% - - - - - - - - - - - - - - - - - - - - - - - - - - 
def traverse_directory(fun, root_dir, max_depth, current_depth=0):
    if current_depth > max_depth: return False

    for item in os.listdir(root_dir): 
        item_path = os.path.join(root_dir, item)
        if os.path.isdir(item_path):
            flag = fun(item_path)
            if flag == True: return True
            flag = traverse_directory(fun, item_path, max_depth, current_depth + 1)
            if flag == True: return True

# %% - - - - - - - - - - - - - - - - - - - - - - - - - - 
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

    # %% -. -- .. - .- . --- - .. -
    def _fun(root):
        if verbose: print("root", root)

        if not check_for_venv(root, name0, trigger_files): return False
        activate_file = os.path.join(root, "bin", "activate")
        
        # up to_activate
        if not dry_run: 
            open(to_activate_file, "w").write(
                f"source '{activate_file}'"
            )

        print(f"venv found: {root}")
        print(f"activate_file: {activate_file}")
        
        return True
    
    # check root0
    if _fun(root0): return True
    # check the rest
    if traverse_directory(_fun, root0, slevel): return True
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
