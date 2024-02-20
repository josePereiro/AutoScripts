import subprocess

def run_cmd(command):
    process = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    output, error = process.communicate()
    output_str = output.decode("utf-8")
    error_str = error.decode("utf-8")
    if output_str:
        print(output_str)
    if error_str:
        print(error_str)
