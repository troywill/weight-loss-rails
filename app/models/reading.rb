class Reading < ActiveRecord::Base
  belongs_to :user
  validates :user_id, :numericality => true
  validates :weight, :numericality => true

#  default_scope :order => 'created_at DESC'

  def self.last_weight(user_id)
    return Reading.unscoped.order('reading_time DESC').where( :user_id => user_id ).last.weight
  end

  # scope :by_user, lambda do |user_id|
  #   where('user_id == ?', user_id)
  # end
  scope :by_user, lambda { |user_id| where('user_id == ?', user_id) }
  
end
