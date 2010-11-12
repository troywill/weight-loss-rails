class Reading < ActiveRecord::Base
  belongs_to :user
  validates :user_id, :numericality => true
  validates :weight, :numericality => true

  def self.last_weight(user_id)
    return where( :user_id => user_id ).last.weight
  end

#  default_scope :order => 'created_at DESC'

  # scope :by_user, lambda do |user_id|
  #   where('user_id == ?', user_id)
  # end
  scope :by_user, lambda { |user_id| where('user_id == ?', user_id) }
  
end
