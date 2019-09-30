#!/bin/bash

###############
# Name: current directory link to www
# Author: Ztj
# Email: ztj1993@gmail.com
# LastDate: 2019-09-30
# Use: curl -fsSL https://dwz.cn/biLTsLPt | sudo bash
###############

set -e

cur_dir=$(pwd)
www_dir=${www_dir:-/var/www/html}
date_time=$(date +%Y-%m-%d-%H-%M-%S)

[ -L ${www_dir} ] && rm -rf ${www_dir}
[ -e ${www_dir} ] && mv ${www_dir} ${www_dir}.backup.${date_time}

ln -s ${cur_dir} ${www_dir}
