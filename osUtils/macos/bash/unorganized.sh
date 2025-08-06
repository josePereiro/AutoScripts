## ------------------------------------------------------------
# https://docs.gitignore.io/install/command-line
function gi() { curl -sLw "\n" https://www.toptal.com/developers/gitignore/api/$@ ;}


sound_m4a2mp3() {
  if [[ $# -ne 1 ]]; then
    echo "Usage: m4a2mp3 input.m4a"
    return 1
  fi

  infile="$1"
  if [[ ! -f "$infile" ]]; then
    echo "File not found: $infile"
    return 1
  fi

  outfile="${infile%.*}.mp3"

  ffmpeg -i "$infile" -c:a libmp3lame -q:a 2 "$outfile"
}