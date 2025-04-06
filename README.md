# TBK mini Wiresless 

- This repo contains the source code for the ZMK module TBK mini wireless. 

- Big shoutout to [https://bastardkb.com/](Bastardkb) to open source the design and files.

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
Also the local build is not a replacment for the CI build, just a quick hack to make interations a bit faster, when exeperimentating. 

## Missing 
- Haven't added support for ZMK Studio. I might do it. 

## Creating the layout 

- [https://zmk-physical-layout-converter.streamlit.app/](Physical Layout Convert)

- [https://nickcoutsos.github.io/keymap-layout-tools/](Keymap editor) 
    - Simply copy the keymap file, or use webpage github intergration. 

## Build guide 
- I've collected all the items i bought to assemble this keyboard. See -> [BUILD.md](BUILD)
