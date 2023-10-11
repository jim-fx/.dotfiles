#!/bin/bash
prompt() {
    read -p "$1 (y/n)? " choice
    case "$choice" in
    y | Y) echo "yes" ;;
    n | N) echo "no" ;;
    *) echo "invalid" ;;
    esac
}

[[ "${1}" != "--source-only" ]] && prompt "${@}"
