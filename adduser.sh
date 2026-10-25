#!/usr/bin/env bash
# Debian/Ubuntu: grant sudo membership only after account creation succeeds.
set -euo pipefail
if [[ $(id -u) -ne 0 ]]; then
    printf 'Run as root.\n' >&2
    exit 1
fi
read -r -p 'New user: ' newUser
if ! [[ $newUser =~ ^[a-z_][a-z0-9_-]*$ ]]; then
    printf 'Invalid username.\n' >&2
    exit 1
fi
if id "$newUser" >/dev/null 2>&1; then
    printf 'User already exists.\n' >&2
    exit 1
fi
adduser "$newUser"
usermod -aG sudo "$newUser"
printf 'Created %s and added the account to the sudo group.\n' "$newUser"
