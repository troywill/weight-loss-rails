# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

User.create(:name => 'Troy Will', :email => 'troydwill@gmail.com', :height => 68, :sex => 'Male',
            :goal_start_time => '2011-06-23 21:22:53', :goal_start_weight => 170.97, :goal_loss_rate => 1)

User.create(:name => 'Marv Redshaw', :email => 'marvmgmusa@gmail.com', :height => 68, :sex => 'Male')

Reading.create(:user_id => 1, :reading_time => '2010-11-11 19:58:00', :weight => 191.6)
Reading.create(:user_id => 1, :reading_time => '2011-06-30 07:13:00', :weight => 172)

# class CreateReadings < ActiveRecord::Migration
#   def self.up
#     create_table :readings do |t|
#       t.integer :user_id
#       t.decimal :weight
#       t.datetime :reading_time

#       t.timestamps
#     end
#   end

#   def self.down
#     drop_table :readings
#   end
# end


# 11 Nov 19:59
