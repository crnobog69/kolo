#!/bin/bash

# Function to find available AUR helper
find_aur_helper() {
    if command -v yay &> /dev/null; then
        echo "yay"
    elif command -v paru &> /dev/null; then
        echo "paru"
    elif command -v pikaur &> /dev/null; then
        echo "pikaur"
    elif command -v trizen &> /dev/null; then
        echo "trizen"
    elif command -v aura &> /dev/null; then
        echo "aura"
    else
        echo ""
    fi
}

# Set whether to use AUR based on argument
USE_AUR=false
if [[ "$1" == "--aur" ]]; then
    USE_AUR=true
fi

# Setting up the package manager
if $USE_AUR; then
    PACKAGE_MANAGER=$(find_aur_helper)
    if [[ -z "$PACKAGE_MANAGER" ]]; then
        echo "No AUR helper found."
        exit 1
    fi
else
    PACKAGE_MANAGER="pacman"
fi

sudo $PACKAGE_MANAGER -Sy --no-confirm

# Search packages depending on the package manager
if [[ "$PACKAGE_MANAGER" == "pacman" ]]; then
    selected_package=$(pacman -Sl | fzf --prompt="Package search: " --preview="pacman -Si {2}" --preview-window=right:50% | awk '{print $2}')
else
    selected_package=$($PACKAGE_MANAGER -Sl | fzf --prompt="Package search (AUR included): " --preview="$PACKAGE_MANAGER -Si {2}" --preview-window=right:50% | awk '{print $2}')
fi

# If a package is selected, check if it is already installed
if [[ -n "$selected_package" ]]; then
    if pacman -Qi "$selected_package" &> /dev/null; then
        # Package is installed, offers uninstallation
        read -p "Package '$selected_package' is already installed. Would you like to uninstall it? (Y/n): " choice
        choice=${choice:-y}  # If input is empty, defaults to "y"
        if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
            sudo $PACKAGE_MANAGER -Rns "$selected_package"
        else
            echo "Uninstallation canceled."
        fi
    else
        # Package is not installed, offers installation
        read -p "Package '$selected_package' is not installed. Would you like to install it? (Y/n): " choice
        choice=${choice:-y}  # If input is empty, defaults to "y"
        if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
            sudo $PACKAGE_MANAGER -S "$selected_package"
        else
            echo "Installation canceled."
        fi
    fi
else
    echo "No package selected."
fi
