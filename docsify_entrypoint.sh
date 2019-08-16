#!/bin/bash

set -e

docs_dir=/docsify.docs

if [[ ! -f /docsify_index.html ]]; then
    wget -O /docsify_index.html https://raw.githubusercontent.com/ztj1993/files/master/docsify_index.html
fi

for doc_dir in $(ls ${docs_dir}); do
    if [[ ! -d ${docs_dir}/${doc_dir} ]]; then
        continue
    fi
    if [[ ! -f ${docs_dir}/${doc_dir}/index.html ]]; then
        cp /docsify_index.html ${docs_dir}/${doc_dir}/index.html
    fi
    if [[ -f ${docs_dir}/${doc_dir}/.docsify/_coverpage.md ]]; then
        sed -i "s/coverpage\:.*,/coverpage: true,/" ${docs_dir}/${doc_dir}/index.html
    else
        sed -i "s/coverpage\:.*,/coverpage: false,/" ${docs_dir}/${doc_dir}/index.html
    fi
    if [[ -f ${docs_dir}/${doc_dir}/.docsify/_sidebar.md ]]; then
        sed -i "s/loadSidebar\:.*,/loadSidebar: true,/" ${docs_dir}/${doc_dir}/index.html
    else
        sed -i "s/loadSidebar\:.*,/loadSidebar: false,/" ${docs_dir}/${doc_dir}/index.html
    fi
    if [[ -f ${docs_dir}/${doc_dir}/.docsify/_navbar.md.md ]]; then
        sed -i "s/loadNavbar\:.*,/loadNavbar: true,/" ${docs_dir}/${doc_dir}/index.html
    else
        sed -i "s/loadNavbar\:.*,/loadNavbar: false,/" ${docs_dir}/${doc_dir}/index.html
    fi
done

exec "$@"
