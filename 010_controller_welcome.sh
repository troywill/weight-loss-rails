#!/bin/bash
source ./rrp-lib.sh
rails generate controller welcome index login logout settings graph goal meal sleep
${EDITOR} ${TOP_DIR}/config/routes.rb
mv -iv ${TOP_DIR}/public/index.html /tmp/
