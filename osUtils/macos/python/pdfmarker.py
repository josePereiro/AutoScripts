import os
import subprocess


# taskset -c 0-7 marker_single --languages "es" ./chenUnconventionalUptakeRate2019.pdf

def execute(inputfile, output_dir):
    """
    Spawns a bash command to process the input file and save the result to the output file.
    Replace 'your_bash_command' with the actual command you want to run.
    """
    
    # command = ['taskset', '-c', '0-10', 'marker_single', '--output_dir', output_dir, '--languages', '"en"', '--', inputfile]
    command = ['echo', inputfile]
    
    try:
        # Run the command
        subprocess.run(command, check=True)
        print(f"Processed {inputfile} and saved to {output_dir}")
    except subprocess.CalledProcessError as e:
        print(f"Error processing {inputfile}: {e}")

def process_files():
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

        # Skip directories, only process files
        if not inputfile.endswith(extension):
            print(f"Skipping {inputfile}, invalid extension.")
            continue

        # Skip directories, only process files
        if not os.path.isfile(inputfile):
            print(f"Skipping {inputfile} because file is missing.")
            continue

        inputfile_basename = os.path.basename(inputfile)
        output_file = os.path.join(output_dir, inputfile_basename)
        output_file = output_file.replace(extension, '')
        
        if os.path.exists(output_file):
            print(f"Skipping {inputfile} because {output_file} already exists.")
            continue

        # execute
        print(f"Processing {inputfile}...")
        execute(inputfile, output_dir)
            

if __name__ == "__main__":
    process_files()