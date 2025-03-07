import os
import subprocess


# taskset -c 0-7 marker_single --languages "es" ./chenUnconventionalUptakeRate2019.pdf

def execute(inputfile, output_dir):
    """
    Spawns a bash command to process the input file and save the result to the output file.
    Replace 'your_bash_command' with the actual command you want to run.
    """
    
    # command = ['taskset', '-c', '0-10', 'marker_single', '--output_dir', output_dir, '--languages', '"es"', '--', inputfile]
    command = ['echo', inputfile]
    
    try:
        # Run the command
        subprocess.run(command, check=True)
        print(f"Processed {inputfile} and saved to {outputfile}")
    except subprocess.CalledProcessError as e:
        print(f"Error processing {inputfile}: {e}")

def process_files():
    # Get the current directory
    current_directory = os.getcwd()

    # Iterate over all files in the current directory
    for filename in os.listdir(current_directory):
        # Construct the full path of the input file
        inputfile = os.path.join(current_directory, filename)

        # Skip directories, only process files
        if os.path.isfile(inputfile):

            output_dir = "/home/pereiro/marker"
            os.makedirs(output_dir, exist_ok=True)
            basename = os.path.basename(inputfile)
            outputfile = os.path.join(output_dir, basename)

            # Check if the output file already exists
            if not os.path.exists(outputfile):
                print(f"Processing {inputfile}...")
                execute(inputfile, output_dir)
            else:
                print(f"Skipping {inputfile} because {outputfile} already exists.")

if __name__ == "__main__":
    process_files()