# TbK mini Wiresless 

- This repo contains the source code for the ZMK module TBK mini wireless. 


*Important!: Overall notes as I'm stil building and testing.* 

## Building 

- Using ZMKs container to quick and painless setup.

1. Install podman on your host system. For ubuntu it can be done like this
```
     sudo apt install podman
```

2. Run the `build_keyboard_local.sh` script. 
```
    ./scripts/build_keyboard_local.sh
```
- Above script will download Image, start container and build this keyboard. All build files will be placed in a new folder `build`
- It'll also create a secret file, saving the container ID, so when building again it'll be a bit faster. If you need to rebuild the container simply delete the file `.zmk_container_id`

*IMPORTANT* 
Due to laziness, the build script does not handle being sourced from different locations in the filesystem. Please source the script from the repository root folder as shown in `step 2`.

## Creating the layout 

https://zmk-physical-layout-converter.streamlit.app/ <- Physical layout converter. Convert from json format, which is used in QMK and maybe others that i'm not aware of. 

https://nickcoutsos.github.io/keymap-layout-tools/ <- Text rendering tool 

https://nickcoutsos.github.io/keymap-layout-tools/ <- keymap layout editor. Input is json file and current keymap file to further edit. 
