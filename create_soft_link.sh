#!/bin/bash

set -e

# Function to determine VSCode user config path
get_vscode_config_dir() {
    unameOut="$(uname -s)"
    case "${unameOut}" in
        Linux*)     VS_DIR="${HOME}/.config/Code/User";;
        Darwin*)    VS_DIR="${HOME}/Library/Application Support/Code/User";;
        *)          echo "Unsupported OS: ${unameOut}"; exit 1;;
    esac
    echo "${VS_DIR}"
}

# Function to determine Cursor user config path
get_cursor_config_dir() {
    unameOut="$(uname -s)"
    case "${unameOut}" in
        Linux*)     CURSOR_DIR="${HOME}/.config/Cursor/User";;
        Darwin*)    CURSOR_DIR="${HOME}/Library/Application Support/Cursor/User";;
        *)          echo "Unsupported OS: ${unameOut}"; exit 1;;
    esac
    echo "${CURSOR_DIR}"
}

# Symlink all files & dirs under nvim_config/
NVIM_SRC="nvim_config"
NVIM_DEST="${HOME}/.config/nvim"
mkdir -p "${NVIM_DEST}"
for item in $(ls -A "${NVIM_SRC}"); do
    src="$(pwd)/${NVIM_SRC}/${item}"
    dest="${NVIM_DEST}/${item}"
    ln -sf "${src}" "${dest}"
done

# Symlink all files & dirs under vscode_config/
VSCODE_SRC="vscode_config"
VSCODE_DEST=$(get_vscode_config_dir)
mkdir -p "${VSCODE_DEST}"
for item in $(ls -A "${VSCODE_SRC}"); do
    src="$(pwd)/${VSCODE_SRC}/${item}"
    dest="${VSCODE_DEST}/${item}"
    ln -sf "${src}" "${dest}"
done
CURSOR_DEST=$(get_cursor_config_dir)
mkdir -p "${CURSOR_DEST}"
for item in $(ls -A "${VSCODE_SRC}"); do
    src="$(pwd)/${VSCODE_SRC}/${item}"
    dest="${CURSOR_DEST}/${item}"
    ln -sf "${src}" "${dest}"
done

# Symlink gitconfig to ~/.gitconfig
ln -sf "$(pwd)/gitconfig" "${HOME}/.gitconfig"

# Symlink wezterm.lua to ~/.wezterm.lua
ln -sf "$(pwd)/wezterm.lua" "${HOME}/.wezterm.lua"

