class User < ApplicationRecord
  self.table_name = 'users'
  self.primary_key = 'id'
  has_secure_token
end
