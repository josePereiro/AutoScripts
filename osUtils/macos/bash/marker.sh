#TODO/ Move out?

# Fill PROXY_POOL array to access the proxies
# MARKER_PDF_LOCAL_REPO[1]="/local/path"
# MARKER_PDF_REMOTES[1]="username@8.8.8.8:/cluster/path"

marker_sync_pdf_remote () {
    local REMOTE=${MARKER_PDF_REMOTES[$1]}
    local LOCAL=${MARKER_PDF_LOCAL_REPO[$1]}
    echo "PUSHING"
    rsync -av --ignore-existing "${LOCAL}/" "${REMOTE}"
    echo "PULLING"
    rsync -av --ignore-existing "${REMOTE}/" "${LOCAL}"
}

# MARKER_MARKDOWN_REMOTES[1]="username@8.8.8.8:/cluster/path"
# MARKER_MARKDOWN_LOCAL_REPO[1]="/local/path"

marker_sync_markdown_remote () {
    local REMOTE=${MARKER_MARKDOWN_REMOTES[$1]}
    local LOCAL=${MARKER_MARKDOWN_LOCAL_REPO[$1]}
    echo "PULLING"
    rsync -av --ignore-existing "${REMOTE}/" "${LOCAL}"
    echo "PUSHING"
    rsync -av --ignore-existing "${LOCAL}/" "${REMOTE}"
}