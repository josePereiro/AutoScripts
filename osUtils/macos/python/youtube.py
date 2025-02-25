import os
import yt_dlp
import argparse
import subprocess

# defaults
home_dir = os.path.expanduser("~")
download_dir = os.path.join(home_dir, "Downloads", "Videos")
links_file = os.path.join(download_dir, "links.txt")

# cli
parser = argparse.ArgumentParser(description='Descargar videos de YouTube desde un archivo de enlaces.')
parser.add_argument('--links-file', type=str, default=links_file, help='links file path (an url per line please)')
parser.add_argument("--open-links", action="store_true", help="Open links file")
args = parser.parse_args()

# open default links
if args.open_links:
  subprocess.run(["code", links_file])
  exit()

# links_file
links_file = args.links_file

# check out directory
if not os.path.exists(download_dir):
  os.makedirs(download_dir)


# read links_file urls
try:
  print(">>>>>>>>>>>>>>>>>>>>>>")
  print("Link file: ", links_file)
  print()

  with open(links_file, "r") as file:
    video_links = [line.strip() for line in file if line.strip()]
  
  nlinks = len(video_links)

  # configure yt-dlp
  outtmpl = os.path.join(download_dir, '%(title)s.%(ext)s')
  ydl_opts = {
      'format': 'best',  # best quality
      'outtmpl': outtmpl, # file name
  }

  # iter urls
  errors = []
  for (linki, link) in enumerate(video_links):
    print('--------------------------')
    print('Downloading')
    print(f"[{linki+1}/{nlinks}] {link}...")
    
    # download video
    try:
      # Descargar el video
      with yt_dlp.YoutubeDL(ydl_opts) as ydl:
        ydl.download([link])
        print()
        print(f"DONE: {link}")
    except Exception as e:
      print()
      print(f"ERROR {link}: {e}")
      errors.append([linki, link, e])

  # show errors
  print()
  print("!!!!!!!!!!!!!!!!!!!!!!")
  if len(errors) > 0:
    print("ERRORS")
    for err in errors:
      print(f"  [{err[0]+1}] {err[1]} -> {err[2]}")
  else:
    print("NO ERRORS")

  print()
  print("<<<<<<<<<<<<<<<<<<<<<<")
  print("END...")

except FileNotFoundError:
  print(
      f"links_file missing, links_file: '{links_file}'")
except Exception as e:
  print(f"ERRROR reading links_file: {e}")
