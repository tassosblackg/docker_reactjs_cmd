#!/bin/bash
# run nodejs image

# declare c_path,path_img variable
c_path="/usr/src/app"
img_name="reactjs:latest"

####
# docker run -it -v host_path:container_path -w container_path image_name path_image
####

args=("$@")
v_path=${args[0]}":c_path"

# numner of args values
argc=${#args[@]}
# one args only host directory
if [$argc -eq 1]; then
  docker run -it -v ${v_path} -w ${c_path} ${img_name} /bin/bash
# two args host directory and different image instance
elif [$argc -eq 2]; then
  docker run -it -v ${v_path} -w ${c_path} ${args[1]} /bin/bash
else
  echo "[**Warning!**] argc > 2 not specified condition for docker_node_img     script![Review..\n]"
fi
