#!/bin/bash

# Function to print usage instructions
usage() {
    echo "Usage: $0 [--init]"
    echo "  --init   Perform west workspace initialization (optional)"
    exit 1
}

# Parse command-line arguments
INIT_WORKSPACE=false

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --init) INIT_WORKSPACE=true ;;
        *) usage ;;
    esac
    shift
done

# Conditionally initialize west workspace if --init flag is used
if [ "$INIT_WORKSPACE" = true ]; then
    echo "Initializing west workspace..."
    west init -l zmk-config
fi

# Update west workspace
west update

# Export Zephyr SDK
west zephyr-export

# Build right side firmware
west build --pristine=auto -s zmk/app -d /workspaces/build/tbk_right -b nice_nano_v2 -- \
  -DZMK_CONFIG=/workspaces/zmk-config/ \
  -DSHIELD=tbk_right \
  -DZMK_EXTRA_MODULES=/workspaces/zmk-modules

# Build left side firmware
west build --pristine=auto -s zmk/app -d /workspaces/build/tbk_left -b nice_nano_v2 -- \
  -DZMK_CONFIG=/workspaces/zmk-config/ \
  -DSHIELD=tbk_left \
  -DZMK_EXTRA_MODULES=/workspaces/zmk-modules
