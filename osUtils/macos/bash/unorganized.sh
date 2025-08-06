## ------------------------------------------------------------
# https://docs.gitignore.io/install/command-line
function gi() { curl -sLw "\n" https://www.toptal.com/developers/gitignore/api/$@ ;}




# mp3_m4a2mp3() {
#   if [[ $# -ne 1 ]]; then
#     echo "Usage: sound_m4a2mp3 input.m4a"
#     return 1
#   fi

#   infile="$1"
#   if [[ ! -f "$infile" ]]; then
#     echo "File not found: $infile"
#     return 1
#   fi

#   outfile="${infile%.*}.mp3"

#   ffmpeg -i "$infile" -c:a libmp3lame -q:a 2 "$outfile"
# }


mp3_from_m4a_all() {
  shopt -s nullglob

  for infile in *.m4a; do
    outfile="${infile%.m4a}.mp3"
    if [[ -f "$outfile" ]]; then
      echo "Skipping $infile (already converted)"
    else
      echo "Converting $infile → $outfile"
      ffmpeg -i "$infile" -c:a libmp3lame -q:a 2 "$outfile"
    fi
  done
}