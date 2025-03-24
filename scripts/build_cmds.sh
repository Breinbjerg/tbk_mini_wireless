# Initialize west workspace
west init -l zmk-config

# Update west workspace
west update

# Export Zephyr SDK
west zephyr-export

# Build right side firmware
west build -s zmk/app -d /workspaces/build/tbk_right -b nice_nano_v2 -- \
  -DZMK_CONFIG=/workspaces/zmk-config/ \
  -DSHIELD=tbk_right \
  -DZMK_EXTRA_MODULES=/workspaces/zmk-modules

# Build left side firmware
west build -s zmk/app -d /workspaces/build/tbk_left -b nice_nano_v2 -- \
  -DZMK_CONFIG=/workspaces/zmk-config/ \
  -DSHIELD=tbk_left \
  -DZMK_EXTRA_MODULES=/workspaces/zmk-modules\

