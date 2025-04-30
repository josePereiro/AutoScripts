#TODO/ Move out?

# Fill PROXY_POOL array to access the proxies
MARKER_PDF_LOCAL_REPO[1]="/Users/Pereiro/Desktop/reading"
MARKER_PDF_REMOTES[1]="pereiro@10.6.230.13:/home/pereiro/reading"

marker_sync_pdf_remote () {
    local REMOTE=${MARKER_PDF_REMOTES[$1]}
    local LOCAL=${MARKER_PDF_LOCAL_REPO[$1]}
    rsync -av --ignore-existing "${LOCAL}/" "${REMOTE}"
    rsync -av --ignore-existing "${REMOTE}/" "${LOCAL}"
}

MARKER_MARKDOWN_REMOTES[1]="pereiro@10.6.230.13:/home/pereiro/marker"
MARKER_MARKDOWN_LOCAL_REPO[1]="/Users/Pereiro/marker"

marker_sync_markdown_remote () {
    local REMOTE=${MARKER_MARKDOWN_REMOTES[$1]}
    local LOCAL=${MARKER_MARKDOWN_LOCAL_REPO[$1]}
    rsync -av --ignore-existing "${REMOTE}/" "${LOCAL}"
    rsync -av --ignore-existing "${LOCAL}/" "${REMOTE}"
}