# search for a 'pyvenv.cfg' and activates its source bin/activate

# %% - - - - - - 

# %% - - - - - - 
import os

def search_files(directory, file_extension):
    found_files = []
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith(file_extension):
                found_files.append(os.path.join(root, file))
    return found_files

directory = '/path/to/your/directory'
file_extension = '.txt'  # Example file extension you want to search for

found_files = search_files(directory, file_extension)
for file in found_files:
    print(file)
