#!/bin/bash

# ZMK Firmware Build Script for Podman Container
# It'll take a few minutes - Mostly due to "west update" command takes some time. 


# Check if Podman is installed
if ! command -v podman &> /dev/null; then
    echo "Podman is not installed. Please install Podman first."
    exit 1
fi

# Define paths
CONFIG_PATH="config"
MODULES_PATH="."
BUILD_PATH="build"

# Create build directory if it doesn't exist
if [ ! -d "$BUILD_PATH" ]; then
    echo "Build directory not found. Creating $BUILD_PATH"
    mkdir -p "$BUILD_PATH"
fi

# Container image to use
ZMK_CONTAINER="docker.io/zmkfirmware/zmk-dev-arm:3.5"

# Run Podman container with build commands
podman run -it --rm \
  --security-opt label=disable \
  --workdir /workspaces \
  -v "$CONFIG_PATH:/workspaces/zmk-config" \
  -v "$MODULES_PATH:/workspaces/zmk-modules" \
  -v "$BUILD_PATH:/workspaces/build" \
  -p 3000:3000 \
  "$ZMK_CONTAINER" ./zmk-modules/scripts/build_cmds.sh
