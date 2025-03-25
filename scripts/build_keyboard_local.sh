#!/bin/bash
# ZMK Firmware Build Script for Podman Container
# It'll take a few minutes - Mostly due to "west update" command takes some time. 


CUR_DIR=$(pwd)

# Container ID storage file
CONTAINER_ID_FILE="$CUR_DIR/.zmk_container_id"

# Check if Podman is installed
if ! command -v podman &> /dev/null; then
    echo "Podman is not installed. Please install Podman first."
    exit 1
fi

# Define paths
CONFIG_PATH="$CUR_DIR/config"
MODULES_PATH="$CUR_DIR"
BUILD_PATH="$CUR_DIR/build"

# Create build directory if it doesn't exist
if [ ! -d "$BUILD_PATH" ]; then
    echo "Build directory not found. Creating $BUILD_PATH"
    mkdir -p "$BUILD_PATH"
    CONTAINDER_ID=$(cat $CONTAINER_ID_FILE)
    echo $CONTAINDER_ID
    podman rm $CONTAINDER_ID
    rm $CONTAINER_ID_FILE
fi

# Container image to use
ZMK_CONTAINER="docker.io/zmkfirmware/zmk-dev-arm:3.5"

# Check if a previous container exists
if [ -f "$CONTAINER_ID_FILE" ]; then
    EXISTING_CONTAINER=$(cat "$CONTAINER_ID_FILE")
    
    # Check if the container still exists
    if podman inspect "$EXISTING_CONTAINER" &> /dev/null; then
        echo "Reusing existing container: $EXISTING_CONTAINER"
        podman start "$EXISTING_CONTAINER"
        podman exec -it "$EXISTING_CONTAINER" /bin/bash zmk-modules/scripts/build_cmds.sh
        exit 0
    else
        echo "no Previous container. Creating a new one."
    fi
fi

# Run new Podman container
CONTAINER_ID=$(podman run -it -d \
  --security-opt label=disable \
  --workdir /workspaces \
  -v "$CONFIG_PATH:/workspaces/zmk-config" \
  -v "$MODULES_PATH:/workspaces/zmk-modules" \
  -v "$BUILD_PATH:/workspaces/build" \
  -p 3000:3000 \
  "$ZMK_CONTAINER" /bin/bash)

# Save the new container ID
echo "$CONTAINER_ID" > "$CONTAINER_ID_FILE"

# Execute build commands
podman exec -it "$CONTAINER_ID" /bin/bash zmk-modules/scripts/build_cmds.sh --init
