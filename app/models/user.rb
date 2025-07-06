class User < ApplicationRecord
 before_save { self.email = email.downcase }
 has_many :articles
 has_secure_password
end