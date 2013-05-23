#!/bin/sh

rails generate scaffold setting user_id:integer \
    filter_rate_gain:integer \
    filter_rate_loss:integer \
    custom_graph:boolean \
    graph_upper:integer \
    graph_lower:integer \
    graph_lines:integer \
    si:boolean \
    clothing:boolean \
    clothing_wt:decimal\
    timezone:integer \
    locale:string
