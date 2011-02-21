class Reading < ActiveRecord::Base
  belongs_to :user
  validates :user_id, :numericality => true
  validates :weight, :numericality => true

  def self.last_weight(user_id)
    return Reading.order('reading_time ASC').where( :user_id => user_id ).last.weight
  end

  def self.last_reading(user_id)
    return Reading.where( :user_id => user_id ).order('reading_time ASC').last
  end

  # scope :by_user, lambda do |user_id|
  #   where('user_id == ?', user_id)
  # end
  scope :by_user, lambda { |user_id| where('user_id == ?', user_id) }

  def self.get_readings_after(user_id,start_time,end_time)
    return Reading.order('reading_time ASC').where( :user_id => user_id ).where( 'reading_time >= ? AND reading_time <= ?', start_time,end_time)
  end

  def self.get_next_reading_after(user_id,time)
    next_reading = Reading.order('reading_time ASC').where( :user_id => user_id ).where( 'reading_time > ?', time).first
  end
  
end
