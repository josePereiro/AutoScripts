git rm --cached "/Users/pereiro/AutoScripts/macos/julia/Manifest.toml"
git commit -m "Remove julia/Manifest.toml from tracking"
git filter-branch --force --index-filter "git rm --cached --ignore-unmatch /Users/pereiro/AutoScripts/macos/julia/Manifest.toml" --prune-empty --tag-name-filter cat -- --all
git push origin --force --all