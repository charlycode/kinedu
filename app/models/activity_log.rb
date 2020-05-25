class ActivityLog < ApplicationRecord
  self.table_name = 'activity_logs'
  self.primary_key = 'id'

  belongs_to :assistant, :class_name => 'Assistant', :foreign_key => :assistant_id
  belongs_to :activity, :class_name => 'Activity', :foreign_key => :activity_id
  belongs_to :baby, :class_name => 'Baby', :foreign_key => :baby_id

end
