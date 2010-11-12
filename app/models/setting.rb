class Setting < ActiveRecord::Base
  belongs_to :user
  validates :user_id, :presence => true, :numericality => true
  validates :weight_loss_rate, :numericality => true

  def self.get_edit_id( user_id )
    id = Setting.where('user_id == ?', user_id).last
    return id
  end

end
