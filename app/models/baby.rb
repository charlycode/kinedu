class Baby < ApplicationRecord
  self.table_name = 'babies'
  self.primary_key = 'id'

  has_many :activity_logs, :class_name => 'ActivityLog', :foreign_key => :baby_id

end