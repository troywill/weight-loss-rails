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

  def self.get_rate( user_id )
    rate = Setting.where('user_id == ?', user_id).last.weight_loss_rate
  end

  def self.get_start_time( user_id )
    start_time = Setting.where('user_id == ?', user_id).last.start_time
    return start_time
  end

  def self.get_total_time( user_id )
    start_time = Setting.where('user_id == ?', user_id).last.start_time
    return Time.now - start_time
  end

end
