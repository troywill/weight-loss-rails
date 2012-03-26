#!/bin/bash
source ./lib-rrp
NAME='setting'

function do_generate () {
    rails generate scaffold ${NAME} \
	user_id:integer \
	one_hour:boolean \
	twelve_hours:boolean \
	one_day:boolean \
	three_days:boolean \
	one_week:boolean \
	four_weeks:boolean \
	one_year:boolean \
	four_years:boolean
}

function edit_model () {
    MODEL="${TOP_DIR}/app/models/${NAME}.rb"
    cat >> ${MODEL} <<EOF
  belongs_to :user
EOF

    $EDITOR ${MODEL}

    echo "Don't forget to edit foreign key model, if applicable" && sleep 1
    
}

function do_migration () {
    read -p "Run db:migrate? <Ctrl-C> to quit" && rake db:migrate
}

###### Main program #######

do_generate
edit_model
do_migration
