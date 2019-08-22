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
###############

set -e

domain=${1}
skip_confirm=${2:-no}

[[ -z ${domain} ]] && read -p ">>> Please enter the domain: " read_domain
[[ -z ${domain} ]] && [[ -z ${read_domain} ]] && echo ">>> Please enter the correct  domain." && exit 1
[[ -n ${read_domain} ]] && domain=${read_domain}

echo ">>> Domain=${domain}"

[[ "${skip_confirm}" != "yes" ]] && read -p ">>> Please confirm(yes/no): " read_confirm
[[ "${skip_confirm}" != "yes" ]] && [[ ${read_confirm} != "yes" ]] && echo ">>> Not confirmed." && exit 1

ssl_dir=/etc/nginx/ssl/${domain}

docker exec web_acme --issue -d ${domain} -d *.${domain} --dns dns_ali

docker  exec \
    -e DEPLOY_DOCKER_CONTAINER_KEY_FILE="${ssl_dir}/key" \
    -e DEPLOY_DOCKER_CONTAINER_CERT_FILE="${ssl_dir}/cert" \
    -e DEPLOY_DOCKER_CONTAINER_CA_FILE="${ssl_dir}/ca" \
    -e DEPLOY_DOCKER_CONTAINER_FULLCHAIN_FILE="${ssl_dir}/fullchain" \
    -e DEPLOY_DOCKER_CONTAINER_RELOAD_CMD="nginx -s reload" \
    web_acme --deploy -d ${domain} --deploy-hook docker
