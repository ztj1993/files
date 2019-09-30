#!/bin/bash

###############
# Name: current directory link to www
# Author: Ztj
# Email: ztj1993@gmail.com
# LastDate: 2019-06-19
# Use:
#     wget https://raw.githubusercontent.com/ztj1993/files/master/shell/cur_to_www.sh
#     chmod +x cur_to_www.sh
#     sudo ./cur_to_www.sh
###############

set -e

cur_dir=$(pwd)
www_dir=${www_dir:-/var/www/html}
date_time=$(date +%Y-%m-%d-%H-%M-%S)

[ -L ${www_dir} ] && rm -rf ${www_dir}
[ -e ${www_dir} ] && mv ${www_dir} ${www_dir}.backup.${date_time}

ln -s ${cur_dir} ${www_dir}
