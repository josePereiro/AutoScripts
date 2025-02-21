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

def download_video(link):
  try:
    # configure yt-dlp
    outtmpl = os.path.join(download_dir, '%(title)s.%(ext)s')
    ydl_opts = {
        'format': 'best',  # best quality
        'outtmpl': outtmpl, # file name
    }
    # Descargar el video
    with yt_dlp.YoutubeDL(ydl_opts) as ydl:
      print(f"Downloading: {link}...")
      ydl.download([link])
      print(f"DONE: {link}")
  except Exception as e:
    print(f"ERROR {link}: {e}")


# read links_file urls
try:
  with open(links_file, "r") as file:
    video_links = [line.strip() for line in file if line.strip()]

  # download
  for link in video_links:
    download_video(link)

  print("ALL DONE!!!")
except FileNotFoundError:
  print(
      f"links_file missing, links_file: '{links_file}'")
except Exception as e:
  print(f"ERRROR reading links_file: {e}")
