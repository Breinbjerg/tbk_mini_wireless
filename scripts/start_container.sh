# Start ZMK container in interactive mode 
# When done you're ready to run "west <commands>"


podman run -it --rm \
  --security-opt label=disable \
  --workdir /workspaces \
  -v "../config/:/workspaces/zmk-config" \
  -v "../:/workspaces/zmk-modules" \
  -p 3000:3000 \
  docker.io/zmkfirmware/zmk-dev-arm:3.5 /bin/bash
