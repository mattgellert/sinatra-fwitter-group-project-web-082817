class User < ActiveRecord::Base
has_many :tweets

  def self.find_by_slug(slug)
    username = slug.split("-").join(" ")
    user = User.find_by(username: username)
  end

  def slug
    self.username.split(" ").join("-")
  end

  def authenticate(password)
    if self.password != password
      false
    else
      self
    end
  end

end
