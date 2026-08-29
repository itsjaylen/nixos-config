#!/usr/bin/env bash
set -euo pipefail

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Default values
MODE="switch"
TARGET_HOST=""

# Parse positional arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
  dry-build | dry)
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
    TARGET_HOST="$1"
    shift
    ;;
  esac
done

# Fallback to system hostname if no host argument was provided
HOSTNAME="${TARGET_HOST:-$(hostname -s)}"

echo -e "${BLUE}==> Preparing Nix flake (Mode: ${GREEN}$MODE${BLUE}, Host: ${GREEN}$HOSTNAME${BLUE})...${NC}"

HOST_DIR="hosts/$HOSTNAME"

# Automatically create the host directory if it doesn't exist yet
if [ ! -d "$HOST_DIR" ]; then
  echo -e "${BLUE}==> Creating missing host directory '$HOST_DIR'...${NC}"
  mkdir -p "$HOST_DIR"
fi

# Generate hardware-configuration.nix if it's missing
if [ ! -f "$HOST_DIR/hardware-configuration.nix" ]; then
  echo -e "${BLUE}==> Generating $HOST_DIR/hardware-configuration.nix...${NC}"
  sudo nixos-generate-config --show-hardware-config >"$HOST_DIR/hardware-configuration.nix"
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
fi