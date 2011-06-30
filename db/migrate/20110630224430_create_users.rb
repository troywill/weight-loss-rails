class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.decimal :height
      t.string :sex
      t.decimal :goal_start_weight
      t.datetime :goal_start_time
      t.integer :goal_loss_rate
      t.integer :filter_rate_gain
      t.integer :filter_rate_loss
      t.integer :forward_rate
      t.string :google_doc

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
