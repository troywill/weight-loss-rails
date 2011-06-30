class Reading < ActiveRecord::Base
  belongs_to :user
  validates :user_id, :numericality => true
  validates :weight, :numericality => true

  scope :by_user, lambda { |user_id| where('user_id == ?', user_id) }
  
end
