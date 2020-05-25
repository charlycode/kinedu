class Baby < ApplicationRecord
  self.table_name = 'babies'
  self.primary_key = 'id'

  has_many :acti

end