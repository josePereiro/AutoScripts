
## ------------------------------------------------------------
# Proxy settings

# Fill PROXY_POOL array to access the proxies
# PROXY_POOL[1]="http://username:password@proxypath:port/"

sh_print_proxy_setting () {
    local PROXY=${PROXY_POOL[$1]}
    echo "http_proxy='${PROXY}'"
    echo "https_proxy='${PROXY}'"
}

sh_set_proxy () {
    local PROXY=${PROXY_POOL[$1]}
    eval "export http_proxy=${PROXY}"
    eval "export https_proxy=${PROXY}"
    [[ $- == *i* ]] || return
    sh_print_proxy_setting $1
}

# clear
unset http_proxy
unset https_proxy