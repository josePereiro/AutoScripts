import os
import subprocess
import argparse

def main():

    # Set up argument parser
    parser = argparse.ArgumentParser(description="Call marker on a folder")
    # parser.add_argument("original_string", type=str, help="The original string to modify.")
    # parser.add_argument("old_fragment", type=str, help="The fragment to replace.")
    parser.add_argument("--languages", type=str, help="marker --languages.", default = 'en')
    parser.add_argument("--dry", action="store_true", help="Dry run")
    parser.add_argument("--force", action="store_true", help="Overwrite previous work")

    # Parse arguments
    args = parser.parse_args()

    # Call the replace function
    # replace_fragment(args.original_string, args.old_fragment, args.new_fragment, args.dry)

    # Get the current directory
    current_directory = os.getcwd()
    current_basename = os.path.basename(current_directory)

    home_dir = os.path.expanduser("~")
    output_dir = os.path.join(home_dir, "marker", current_basename)
    os.makedirs(output_dir, exist_ok=True)

    extension = ".pdf"

    # Iterate over all files in the current directory
    for filename in os.listdir(current_directory):

        print('----------------------')

        # Construct the full path of the input file
        inputfile = os.path.join(current_directory, filename)
        print(f"inputfile: {inputfile}")

        # Skip directories, only process files
        if not inputfile.endswith(extension):
            print(f"Skipping, invalid extension.")
            continue

        # Skip directories, only process files
        if not os.path.isfile(inputfile):
            print(f"Skipping, because file is missing.")
            continue

        inputfile_basename = os.path.basename(inputfile).replace(extension, '')
        sentinel_name = f"{inputfile_basename}.md"
        sentinel_file = os.path.join(output_dir, inputfile_basename, sentinel_name)
        print(f"sentinel_file: {sentinel_file}")
        if not args.force and os.path.exists(sentinel_file):
            print(f"Skipping, sentinel_file already exists.")
            continue

        # execute
        print(f"Processing...")
        if args.dry:
            command = ['echo', 'dry-run', inputfile]
        else:
            command = ['taskset', '-c', '0-10', 'marker_single', '--output_dir', output_dir, '--languages', '"en"', '--', inputfile]
        
        try:
            # Run the command
            subprocess.run(command, check=True)
            print(f"DONE!!!")
        except subprocess.CalledProcessError as e:
            print(f"Error!!! {e}")

            

if __name__ == "__main__":
    main()