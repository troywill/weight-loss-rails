class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :phone, :default => "000-00-0000"
      t.decimal :height
      t.string :sex
      t.decimal :start_weight, :default => 100
      t.datetime :start_time, :default => Time.now
      t.integer :weight_loss_rate, :default => 1
      t.integer :filter_rate_gain, :default => 500
      t.integer :filter_rate_loss, :default  => 2000
      t.integer :forward_rate, :default => 500
      t.string :google_doc, :default => "http://docs.google.com"

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
