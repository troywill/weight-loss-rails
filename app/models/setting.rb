class Setting < ActiveRecord::Base
  belongs_to :user
  validates :user_id, :presence => true, :numericality => true
  validates :weight_loss_rate, :numericality => true

  def self.get_edit_id( user_id )
    id = Setting.where('user_id == ?', user_id).last
    return id
  end

  def self.get_start_weight( user_id )
    start_weight = Setting.where('user_id == ?', user_id).last.start_weight
    return start_weight
  end

  def self.get_start_time( user_id )
    start_time = Setting.where('user_id == ?', user_id).last.start_time
    return start_time.to_i
  end

end
