#!/bin/bash
set -o errexit
set -o nounset

# <troydwill@gmail.com> 2012-02-01
source ./lib-rrp
rails generate controller welcome index login logout
sleep 5
${EDITOR} ${TOP_DIR}/config/routes.rb
mv -iv ${TOP_DIR}/public/index.html /tmp/
