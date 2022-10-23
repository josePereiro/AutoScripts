# npm config set proxy http://username:password@host:port
# npm config set https-proxy http://username:password@host:port

## ------------------------------------------------------------
# Proxy settings

# Fill PROXY_POOL array to access the proxies
# PROXY_POOL[1]="http://username:password@proxypath:port/"

npm_print_proxy_setting () {
    local PROXY=${PROXY_POOL[$1]}
    echo "npm config set proxy '${PROXY}'"
    echo "npm config set https-proxy '${PROXY}'"
}

npm_set_proxy () {
    local PROXY=${PROXY_POOL[$1]}
    eval "npm config set proxy '${PROXY}'"
    eval "npm config set https-proxy '${PROXY}'"
    [[ $- == *i* ]] || return
    npm_print_proxy_setting $1
}

