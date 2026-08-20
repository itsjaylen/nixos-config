#!/usr/bin/env bash
<<<<<<< HEAD
<<<<<<< HEAD
set -euo pipefail
||||||| parent of 78ad2bb (started remove of slop)
# Exit immediately if a command exits with a non-zero status
set -e
=======
# Exit immediately on failure, pipe fail, and unset variables
||||||| parent of 91e4c16 (base config more)
# Exit immediately on failure, pipe fail, and unset variables
=======
>>>>>>> 91e4c16 (base config more)
set -euo pipefail
>>>>>>> 78ad2bb (started remove of slop)

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
<<<<<<< HEAD
<<<<<<< HEAD
RED='\033[0;31m'
NC='\033[0m'
||||||| parent of 78ad2bb (started remove of slop)
NC='\033[0m' # No Color
=======
YELLOW='\033[1;33m'
||||||| parent of 91e4c16 (base config more)
YELLOW='\033[1;33m'
=======
>>>>>>> 91e4c16 (base config more)
RED='\033[0;31m'
<<<<<<< HEAD
NC='\033[0m' # No Color
>>>>>>> 78ad2bb (started remove of slop)
||||||| parent of 91e4c16 (base config more)
NC='\033[0m' # No Color
=======
NC='\033[0m'
>>>>>>> 91e4c16 (base config more)

<<<<<<< HEAD
<<<<<<< HEAD
MODE="switch"
TARGET_HOST=""
||||||| parent of 78ad2bb (started remove of slop)
echo -e "${BLUE}==> Preparing Nix flake installation...${NC}"
=======
# Default values
ACTION="switch"
DO_UPDATE=false
||||||| parent of 91e4c16 (base config more)
# Default values
ACTION="switch"
DO_UPDATE=false
=======
MODE="switch"
>>>>>>> 91e4c16 (base config more)
TARGET_HOST=""
>>>>>>> 78ad2bb (started remove of slop)

<<<<<<< HEAD
<<<<<<< HEAD
# Parse positional arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        dry-build|dry)
            MODE="dry-build"
            shift
            ;;
        test)
            MODE="test"
            shift
            ;;
        boot)
            MODE="boot"
            shift
            ;;
        switch)
            MODE="switch"
            shift
            ;;
        vm)
            MODE="vm"
            shift
            ;;
        *)
<<<<<<< HEAD
            TARGET_HOST="$1"
            shift
            ;;
    esac
done

# Fallback to system hostname if no host argument was provided
HOSTNAME="${TARGET_HOST:-$(hostname -s)}"

echo -e "${BLUE}==> Preparing Nix flake (Mode: ${GREEN}$MODE${BLUE}, Host: ${GREEN}$HOSTNAME${BLUE})...${NC}"

HOST_DIR="hosts/$HOSTNAME"

if [ -d "$HOST_DIR" ]; then
    if [ ! -f "$HOST_DIR/hardware-configuration.nix" ]; then
        echo -e "${BLUE}==> Generating $HOST_DIR/hardware-configuration.nix...${NC}"
        sudo nixos-generate-config --show-hardware-config > "$HOST_DIR/hardware-configuration.nix"
    fi
else
    echo -e "${RED}==> Warning: Host directory '$HOST_DIR' does not exist.${NC}"
    echo -e "${BLUE}==> Proceeding, but ensure '$HOSTNAME' is defined in flake.nix.${NC}"
||||||| parent of 78ad2bb (started remove of slop)
# Optional: Automatically generate/refresh hardware-config if missing or on a new machine
if [ ! -f "hardware-configuration.nix" ]; then
    echo -e "${BLUE}==> Generating hardware-configuration.nix...${NC}"
    sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix
=======
# Print Help / Usage
show_help() {
    cat << EOF
Usage: $(basename "$0") [OPTIONS] [PROFILE/HOSTNAME]

Helper script to manage, update, test, and apply NixOS flake configurations.

ARGUMENTS:
  PROFILE/HOSTNAME   The target host profile (e.g., laptop, desktop).
                     Defaults to the current hostname if omitted.

OPTIONS:
  -s, --switch        Apply configuration immediately and set as default boot entry (Default).
  -b, --boot          Build configuration and set as default boot entry without switching now.
  -t, --test          Test configuration build and switch temporary without updating bootloader.
  -u, --update        Update flake.lock inputs before rebuilding.
  -h, --help          Display this help message and exit.

EXAMPLES:
  $(basename "$0")                    # Switch using current hostname profile
  $(basename "$0") laptop              # Switch explicitly to 'laptop' profile
  $(basename "$0") -t laptop           # Test 'laptop' profile temporarily
  $(basename "$0") -u -b desktop       # Update flake inputs & set 'desktop' profile for next boot
EOF
}

# Parse options
||||||| parent of 91e4c16 (base config more)
# Print Help / Usage
show_help() {
    cat << EOF
Usage: $(basename "$0") [OPTIONS] [PROFILE/HOSTNAME]

Helper script to manage, update, test, and apply NixOS flake configurations.

ARGUMENTS:
  PROFILE/HOSTNAME   The target host profile (e.g., laptop, desktop).
                     Defaults to the current hostname if omitted.

OPTIONS:
  -s, --switch        Apply configuration immediately and set as default boot entry (Default).
  -b, --boot          Build configuration and set as default boot entry without switching now.
  -t, --test          Test configuration build and switch temporary without updating bootloader.
  -u, --update        Update flake.lock inputs before rebuilding.
  -h, --help          Display this help message and exit.

EXAMPLES:
  $(basename "$0")                    # Switch using current hostname profile
  $(basename "$0") laptop              # Switch explicitly to 'laptop' profile
  $(basename "$0") -t laptop           # Test 'laptop' profile temporarily
  $(basename "$0") -u -b desktop       # Update flake inputs & set 'desktop' profile for next boot
EOF
}

# Parse options
=======
# Parse positional arguments
>>>>>>> 91e4c16 (base config more)
while [[ $# -gt 0 ]]; do
    case "$1" in
        dry-build|dry)
            MODE="dry-build"
            shift
            ;;
        test)
            MODE="test"
            shift
            ;;
        boot)
            MODE="boot"
            shift
            ;;
        switch)
            MODE="switch"
            shift
            ;;
        vm)
            MODE="vm"
            shift
            ;;
        *)
            # If it's not a recognized mode keyword, treat it as the target host
||||||| parent of 121ad01 (restructure: repair broken refs and update tracking)
            # If it's not a recognized mode keyword, treat it as the target host
=======
>>>>>>> 121ad01 (restructure: repair broken refs and update tracking)
            TARGET_HOST="$1"
            shift
            ;;
    esac
done

# Fallback to system hostname if no host argument was provided
HOSTNAME="${TARGET_HOST:-$(hostname -s)}"

echo -e "${BLUE}==> Preparing Nix flake (Mode: ${GREEN}$MODE${BLUE}, Host: ${GREEN}$HOSTNAME${BLUE})...${NC}"

<<<<<<< HEAD
<<<<<<< HEAD
# Optional Flake Input Updates
if [ "$DO_UPDATE" = true ]; then
    echo -e "${BLUE}==> Updating flake inputs (flake.lock)...${NC}"
    nix flake update
>>>>>>> 78ad2bb (started remove of slop)
fi
||||||| parent of 91e4c16 (base config more)
# Optional Flake Input Updates
if [ "$DO_UPDATE" = true ]; then
    echo -e "${BLUE}==> Updating flake inputs (flake.lock)...${NC}"
    nix flake update
fi
=======
HOST_DIR="./$HOSTNAME"
>>>>>>> 91e4c16 (base config more)
||||||| parent of 121ad01 (restructure: repair broken refs and update tracking)
HOST_DIR="./$HOSTNAME"
=======
HOST_DIR="hosts/$HOSTNAME"
>>>>>>> 121ad01 (restructure: repair broken refs and update tracking)

<<<<<<< HEAD
<<<<<<< HEAD
# Track newly generated and untracked files in Git so Nix Flakes can evaluate them
if [ -d ".git" ]; then
    echo -e "${BLUE}==> Tracking untracked files for Nix flake evaluation...${NC}"
    git add -A
||||||| parent of 78ad2bb (started remove of slop)
# Ensure git is tracking files (Nix ignores untracked files in flakes!)
if [ -n "$(git status --porcelain)" ]; then
    echo -e "${BLUE}==> Staging untracked/modified files for the flake...${NC}"
    git add .
=======
# Ensure target directory exists
if [ ! -d "${TARGET_HOST}" ]; then
    echo -e "${YELLOW}==> Warning: Directory '${TARGET_HOST}/' does not exist.${NC}"
    read -p "Do you want to create directory '${TARGET_HOST}'? [y/N] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        mkdir -p "${TARGET_HOST}"
    else
        echo -e "${RED}==> Aborting installation.${NC}"
        exit 1
||||||| parent of 91e4c16 (base config more)
# Ensure target directory exists
if [ ! -d "${TARGET_HOST}" ]; then
    echo -e "${YELLOW}==> Warning: Directory '${TARGET_HOST}/' does not exist.${NC}"
    read -p "Do you want to create directory '${TARGET_HOST}'? [y/N] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        mkdir -p "${TARGET_HOST}"
    else
        echo -e "${RED}==> Aborting installation.${NC}"
        exit 1
=======
if [ -d "$HOST_DIR" ]; then
    if [ ! -f "$HOST_DIR/hardware-configuration.nix" ]; then
        echo -e "${BLUE}==> Generating $HOST_DIR/hardware-configuration.nix...${NC}"
        sudo nixos-generate-config --show-hardware-config > "$HOST_DIR/hardware-configuration.nix"
>>>>>>> 91e4c16 (base config more)
    fi
<<<<<<< HEAD
>>>>>>> 78ad2bb (started remove of slop)
fi

<<<<<<< HEAD
# Execute mode logic
if [ "$MODE" = "vm" ]; then
    echo -e "${BLUE}==> Building QEMU VM for '$HOSTNAME'...${NC}"
    nixos-rebuild build-vm --flake ".#$HOSTNAME" --accept-flake-config
    echo -e "${GREEN}==> VM build complete! Run with: ./result/bin/run-$HOSTNAME-vm${NC}"
else
    echo -e "${BLUE}==> Running nixos-rebuild $MODE for '$HOSTNAME'...${NC}"
    sudo nixos-rebuild "$MODE" --flake ".#$HOSTNAME" --accept-flake-config
    echo -e "${GREEN}==> Operation '$MODE' for '$HOSTNAME' completed successfully! 🎉${NC}"
fi
||||||| parent of 78ad2bb (started remove of slop)
# Automatically detect the current hostname if not specified
HOSTNAME=$(hostname)
echo -e "${BLUE}==> Target Hostname: ${GREEN}$HOSTNAME${NC}"

# Run the nixos-rebuild switch command (without unsupported flags)
echo -e "${BLUE}==> Rebuilding NixOS configuration...${NC}"
sudo nixos-rebuild switch --flake ".#$HOSTNAME"

echo -e "${BLUE}==> Installation complete! 🎉${NC}"
=======
# Generate/refresh hardware-configuration.nix in target directory
HW_CONFIG="${TARGET_HOST}/hardware-configuration.nix"
if [ ! -f "${HW_CONFIG}" ]; then
    echo -e "${BLUE}==> Generating ${HW_CONFIG}...${NC}"
    sudo nixos-generate-config --show-hardware-config > "${HW_CONFIG}"
    # Fix ownership so your regular user and Git can track/stage it
    sudo chown "$USER:$(id -gn)" "${HW_CONFIG}"
||||||| parent of 91e4c16 (base config more)
fi

# Generate/refresh hardware-configuration.nix in target directory
HW_CONFIG="${TARGET_HOST}/hardware-configuration.nix"
if [ ! -f "${HW_CONFIG}" ]; then
    echo -e "${BLUE}==> Generating ${HW_CONFIG}...${NC}"
    sudo nixos-generate-config --show-hardware-config > "${HW_CONFIG}"
    # Fix ownership so your regular user and Git can track/stage it
    sudo chown "$USER:$(id -gn)" "${HW_CONFIG}"
=======
>>>>>>> 91e4c16 (base config more)
else
    echo -e "${RED}==> Warning: Host directory '$HOST_DIR' does not exist.${NC}"
    echo -e "${BLUE}==> Proceeding, but ensure '$HOSTNAME' is defined in flake.nix.${NC}"
fi

# Track newly generated and untracked files in Git so Nix Flakes can evaluate them
if [ -d ".git" ]; then
    echo -e "${BLUE}==> Tracking untracked files for Nix flake evaluation...${NC}"
    git add -A
fi

# Execute mode logic
if [ "$MODE" = "vm" ]; then
    echo -e "${BLUE}==> Building QEMU VM for '$HOSTNAME'...${NC}"
    nixos-rebuild build-vm --flake ".#$HOSTNAME" --accept-flake-config
    echo -e "${GREEN}==> VM build complete! Run with: ./result/bin/run-$HOSTNAME-vm${NC}"
else
    echo -e "${BLUE}==> Running nixos-rebuild $MODE for '$HOSTNAME'...${NC}"
    sudo nixos-rebuild "$MODE" --flake ".#$HOSTNAME" --accept-flake-config
    echo -e "${GREEN}==> Operation '$MODE' for '$HOSTNAME' completed successfully! 🎉${NC}"
<<<<<<< HEAD
fi
<<<<<<< HEAD

# Rebuild execution
echo -e "${BLUE}==> Running: sudo nixos-rebuild ${ACTION} --flake .#${TARGET_HOST}${NC}"
sudo nixos-rebuild "${ACTION}" --flake ".#${TARGET_HOST}"

echo -e "${GREEN}==> Done! 🎉${NC}"
>>>>>>> 78ad2bb (started remove of slop)
||||||| parent of 91e4c16 (base config more)

# Rebuild execution
echo -e "${BLUE}==> Running: sudo nixos-rebuild ${ACTION} --flake .#${TARGET_HOST}${NC}"
sudo nixos-rebuild "${ACTION}" --flake ".#${TARGET_HOST}"

echo -e "${GREEN}==> Done! 🎉${NC}"
=======
>>>>>>> 91e4c16 (base config more)
||||||| parent of 121ad01 (restructure: repair broken refs and update tracking)
fi
=======
fi
>>>>>>> 121ad01 (restructure: repair broken refs and update tracking)
