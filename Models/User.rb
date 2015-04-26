class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  has_one :profile
  
  def self.getUserFromUser(user)
    name=getName(user)
    return User.find_or_create_by(name: name)
  end
end