class Setting < ActiveRecord::Base
  belongs_to :user
  validates :user_id, :presence => true, :numericality => true
  validates :weight_loss_rate, :numericality => true
end
