class User < ActiveRecord::Base
  validates :name, :presence => true
  validates :username, :presence => true, :uniqueness => true
  validates :password, :presence => true

  def self.authenticate(username, password)
    user = self.find_by_username(username)
    if user
      if user.password != password
        user = nil
      end
    end
    user
  end

end
