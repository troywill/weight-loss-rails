#!/bin/sh

rails generate scaffold goal user_id:integer \
    goal_start_weight:decimal \
    goal_start_time:datetime \
    goal_loss_rate:integer \
    goal_finish_time:datetime
