# --------------------------------------------------------------
# Redirect to osUtils if not yet done
if [ "${_OSUTILS_SOURCE_CONFIG_LOCK_}" != "LOCKED" ] && [ -f /Users/Pereiro/AutoScripts/osUtils/macos/__init__.sh ]; then
    source /Users/Pereiro/AutoScripts/osUtils/macos/__init__.sh
    return 0
fi

# --------------------------------------------------------------