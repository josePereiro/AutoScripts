# push yag
git_push_tag() {
    if [ $# -eq 1 ]; then
        local _tag=$1
        git tag ${_tag}
        git push origin ${_tag}
    fi
}

git_rename_master() {
    git branch -m master main
    git push -u origin main
    git push origin --delete master
}