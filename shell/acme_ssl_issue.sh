#!/bin/bash

###############
# Name: acme ssl issue
# Author: Ztj
# Email: ztj1993@gmail.com
# Date: 2020-02-25
###############

set -e

domain=${domain:-${1:-domain}}
ssl_dir=${ssl_dir:-/etc/nginx/ssl}
acme=${acme:-acme}

[[ -z ${domain} ]] && echo ">>> Not domain." && exit 1

ssl_dir=${ssl_dir}/${domain}

echo ">>> domain=${domain}"
echo ">>> ssl_dir=${ssl_dir}"
echo ">>> acme=${acme}"

docker exec ${acme} --issue -d ${domain} -d *.${domain} --dns dns_ali --force

docker  exec \
    -e DEPLOY_DOCKER_CONTAINER_KEY_FILE="${ssl_dir}/key" \
    -e DEPLOY_DOCKER_CONTAINER_CERT_FILE="${ssl_dir}/cert" \
    -e DEPLOY_DOCKER_CONTAINER_CA_FILE="${ssl_dir}/ca" \
    -e DEPLOY_DOCKER_CONTAINER_FULLCHAIN_FILE="${ssl_dir}/fullchain" \
    -e DEPLOY_DOCKER_CONTAINER_RELOAD_CMD="nginx -s reload" \
    ${acme} --deploy -d ${domain} --deploy-hook docker
