class User < ApplicationRecord
  validates :username, presence: true, 
                      uniqueness: { case_sensitive: false }, 
                      length: { minimum: 3, maximun: 25 }
  validates :email, presence: true, 
                  uniqueness: { case_sensitive: false }, 
                  length: { maximun: 105 }
end
