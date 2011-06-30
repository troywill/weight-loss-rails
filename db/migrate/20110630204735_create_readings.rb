class CreateReadings < ActiveRecord::Migration
  def self.up
    create_table :readings do |t|
      t.integer :user_id
      t.decimal :weight
      t.datetime :reading_time

      t.timestamps
    end
  end

  def self.down
    drop_table :readings
  end
end
