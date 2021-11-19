#!/usr/bin/env bash

isNotInstalled()
{
    if which $1 >/dev/null 2>&1; then
        return 1
    else
        return 0
    fi
}

ensureInstalledSingle()
{
    case $1 in
        rust)
            if isNotInstalled rustup; then
                curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
            fi
            ;;
        stylua)
            ensureInstalled rust
            if isNotInstalled $1; then
                isNotInstalled $1 && cargo install $1
            fi
            ;;
        *)
            echo "unknown dep $1"
            return 1
    esac
    echo ensured $1
}

ensureInstalled()
{
    local var
    for var in "$@"; do
        ensureInstalledSingle $var
    done
}

ensureInstalled rust stylua
