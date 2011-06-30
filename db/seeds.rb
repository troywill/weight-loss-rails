# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

User.create(:name => 'Troy Will', :email => 'troydwill@gmail.com', :height => 68, :sex => 'Male', )
User.create(:name => 'Marv Redshaw', :email => 'marvmgmusa@gmail.com', :height => 68, :sex => 'Male')

