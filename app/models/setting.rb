class Setting < ActiveRecord::Base
  belongs_to :user
  validates :user_id, :presence => true, :numericality => true
  validates :weight_loss_rate, :numericality => true

  scope :by_user, lambda { |user_id| where('user_id == ?', user_id) }
end
