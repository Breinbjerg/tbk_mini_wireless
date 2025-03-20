# Make running commands inside container easy 
#


set -e 

DOCKER_ARGS="--privileged \ 
  --rm=true \ 
  --it \ 
  --network=host \
  -u user \ 
  -v ../:/workspaces/zmk-module \ 
  -v ../config/:/workspaces/zmk-config \ 

   




