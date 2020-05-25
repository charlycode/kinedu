class ActivityLogsController < ApplicationController
  def index
    @babies = Baby.all
    @assistants = Assistant.all
    @activity_logs = ActivityLog.order(start_time: :desc)

  end

  def get_activity_log

  end
end
