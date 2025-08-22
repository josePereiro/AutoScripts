source_if_exists() {
    local file="$1"
    if [[ -f "$file" ]]; then
        source "$file"
    fi
}