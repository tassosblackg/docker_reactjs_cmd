#!/bin/bash
# run nodejs image

# declare c_path,path_img variable
c_path="/usr/src/app"
img_name="node:latest"
h_port=3000
####
# docker run -it -v host_path:container_path -w container_path image_name path_image
####
help_msg(){
    echo -e "reactdev [options] \"string_name\" \n"
    echo -e "--[options]--"
    echo -e "Use -i or --image_name to pass an image name to be used. \n"
    echo -e "Use -hp or --host_port to pass a port number to container's host. \n"
    echo -e "Use -d or --project_name to pass the new project's path folder. \n"
    echo -e "Use -h or --help to ask for help on reactdev. \n"
    echo -e "reactdev custom command using docker_node_img script [**author:tassosblackg**]\n"
    echo -e " see yaa!!"

}

# while loop to arg-parse
while [[ "$#" -gt 0 ]];
    do case $1 in
        -i|--image_name)
            i_name="$2";
            shift
            ;;
        -hp|--host_port)
            h_port="$2";
            shift
            ;;
        -d|--project_name)
            proj_path="$2";
            shift
            ;;
        -h|--help)
            help_msg
            exit 0
            ;;
        *)
            echo -e "[ERROR]Non valid argument!\n ";;
    esac;
    shift;
done
#
# echo -e " \nimage name : ${i_name}"
# echo -e "\n project name : $proj_path"
v_path="${proj_path}:${c_path}"

docker run -it -p ${h_port}:3000 -v ${v_path} -w ${c_path} ${i_name} /bin/bash

#
# if [ "$if_img" -eq 1 ]; then
#
#     docker run -it -v ${v_path} -w ${c_path} ${i_name} /bin/bash
# elif [ "$#" -eq 1 ]; then
#     docker run -it -v ${v_path} -w ${c_path} ${img_name} /bin/bash
# fi
# numner of args values
# argc=${#args[@]}
# one args only host directory
# if [$argc -eq 1]; then
#   docker run -it -v ${v_path} -w ${c_path} ${img_name} /bin/bash
# # two args host directory and different image instance
# elif [$argc -eq 2]; then
#   docker run -it -v ${v_path} -w ${c_path} ${args[1]} /bin/bash
# else
#   echo "[**Warning!**] argc > 2 not specified condition for docker_node_img     script![Review..\n]"
# fi
