#!/bin/bash

###############
# Name: web ssl create(private)
# Author: Ztj
# Email: ztj1993@gmail.com
# LastDate: 2019-06-19
# Use:
#     wget https://raw.githubusercontent.com/ztj1993/files/master/shell/web_ssl.sh
#     chmod +x web_ssl.sh
#     sudo ./web_ssl.sh
#     or
#     curl -fsSL https://raw.githubusercontent.com/ztj1993/files/master/shell/web_ssl.sh | bash
###############

set -e

domain=${domain:-${1:-domain}}
ssl_dir=${ssl_dir:-${2:-/etc/nginx/ssl}}

[[ -z ${domain} ]] && echo ">>> Not domain." && exit 1

ssl_dir=${ssl_dir}/${domain}

echo ">>> domain=${domain}"
echo ">>> ssl_dir=${ssl_dir}"

docker exec web_acme --issue -d ${domain} -d *.${domain} --dns dns_ali

docker  exec \
    -e DEPLOY_DOCKER_CONTAINER_KEY_FILE="${ssl_dir}/key" \
    -e DEPLOY_DOCKER_CONTAINER_CERT_FILE="${ssl_dir}/cert" \
    -e DEPLOY_DOCKER_CONTAINER_CA_FILE="${ssl_dir}/ca" \
    -e DEPLOY_DOCKER_CONTAINER_FULLCHAIN_FILE="${ssl_dir}/fullchain" \
    -e DEPLOY_DOCKER_CONTAINER_RELOAD_CMD="nginx -s reload" \
    web_acme --deploy -d ${domain} --deploy-hook docker
