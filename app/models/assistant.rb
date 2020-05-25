class Assistant < ApplicationRecord
  self.table_name = 'assistants'
  self.primary_key = 'id'

  has_many :activity_logs, :class_name => 'ActivityLog', :foreign_key => :assistant_id

end