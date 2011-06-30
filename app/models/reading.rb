class Reading < ActiveRecord::Base
  belongs_to :user
  validates :user_id, :numericality => true
  validates :weight, :numericality => true
end
