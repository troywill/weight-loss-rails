#!/bin/bash
# <troydwill@gmail.com> 2012-02-01
source ./lib-rrp
rails generate controller welcome index login logout
${EDITOR} ${TOP_DIR}/config/routes.rb
mv -iv ${TOP_DIR}/public/index.html /tmp/
