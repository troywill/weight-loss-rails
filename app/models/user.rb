class User < ActiveRecord::Base
  validates :name, :presence => true
  validates :email, :presence => true, :uniqueness => true

  def self.authenticate(email)
    user = self.find_by_email(email)
    if user
      if user.email != email
        user = nil
      end
    end
    user
  end

end
