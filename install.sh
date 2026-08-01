#!/usr/bin/env bash
# Exit immediately if a command exits with a non-zero status
set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}==> Preparing Nix flake installation...${NC}"

# Optional: Automatically generate/refresh hardware-config if missing or on a new machine
if [ ! -f "hardware-configuration.nix" ]; then
    echo -e "${BLUE}==> Generating hardware-configuration.nix...${NC}"
    sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix
fi

# Ensure git is tracking files (Nix ignores untracked files in flakes!)
if [ -n "$(git status --porcelain)" ]; then
    echo -e "${BLUE}==> Staging untracked/modified files for the flake...${NC}"
    git add .
fi

# Automatically detect the current hostname if not specified
HOSTNAME=$(hostname)
echo -e "${BLUE}==> Target Hostname: ${GREEN}$HOSTNAME${NC}"

# Run the nixos-rebuild switch command (with experimental features enabled)
echo -e "${BLUE}==> Rebuilding NixOS configuration...${NC}"
sudo nixos-rebuild switch --flake ".#$HOSTNAME" --extra-experimental-features "nix-command flakes"

echo -e "${BLUE}==> Installation complete! 🎉${NC}"