# search for a 'pyvenv.cfg' and create a bash script to source it...
# %% - - - - - - - - - - - - - - - - - - - - - - - - - - 
import argparse
import os
from utils import *

def check_for_venv(file, name0, trigger_files):
    if os.path.basename(file) not in trigger_files: return False
    if not name0: return True
    return name0 == os.path.basename(os.path.dirname(file))

def up_activate(root0, name0, trigger_files, to_activate_file, slevel):
    root0 = os.path.expanduser(root0)
    root0 = os.path.abspath(root0)
    if not os.path.isdir(root0): return False

    for root, dirs, files in os.walk(root0):
        root = os.path.abspath(root)
        for file in files:
            file = os.path.join(root, file)
            # print(root)
            if not check_for_venv(file, name0, trigger_files): continue
            activate_file = os.path.join(root, "bin", "activate")
            print(f"venv found: {root}")
            print(f"activate_file: {activate_file}")
            # up to_activate
            open(to_activate_file, "w").write(
                f"source '{activate_file}'"
            )
            return True
        slevel -= 1
        if slevel <= 0: return False
    return False

# %% - - - - - - - - - - - - - - - - - - - - - - - - - - 
def main():
    # CLI
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
    )
    # args = parser.parse_args()
    args, _ = parser.parse_known_args()

    # extract args
    name = args.name
    slevel = args.level
    print(f"cli_name: {name}")
    print(f"cli_slevel: {slevel}")

    # To sync with bash caller
    to_activate_file = os.path.join(
        os.path.dirname(os.path.abspath(__file__)), "_OSUTILS_PYTHON_TO_ACTIVATE_"
    )

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
            slevel
        )
        if flag: return 0

    return 0

if __name__ == "__main__":
    main()
