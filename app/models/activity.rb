class Activity < ApplicationRecord
  self.table_name = 'activities'
  self.primary_key = 'id'

  has_many :activity_logs, :class_name => 'ActivityLog', :foreign_key => :activity_id

end