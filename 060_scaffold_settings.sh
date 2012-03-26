#!/bin/bash
source ./lib-rrp
NAME='goal'

function do_generate () {
    rails generate scaffold ${NAME} \
	user_id:integer \
	end_weight:decimal \
	start_weight:decimal \
	start_date:datetime \
	weight_loss_rate:integer \
	history:text \
	status:integer
}

function edit_model () {
    MODEL="${TOP_DIR}/app/models/${NAME}.rb"
    cat >> ${MODEL} <<EOF
  belongs_to :user
  validates :user_id, :presence => true, :numericality => true
  validates :weight_loss_rate, :presence => true, :numericality => true
  validates :end_weight, :presence => true, :numericality => true
  validates :start_weight, :presence => true, :numericality => true
  validates :weight_loss_rate, :presence => true, :numericality => true
  validates :status, :presence => true, :numericality => true
  validates :start_date, :presence => true
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
