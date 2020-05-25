class ActivityLogsController < ApplicationController
  def index
    @babies = Baby.all
    @assistants = Assistant.all
    @activity_logs = ActivityLog.order(start_time: :desc)

  end

  def get_activities_log
    respond_to do |format|
      if request.post?
        baby_id = params[:baby_id].to_i
        assistant_id = params[:assistant_id].to_i
        status = params[:status].to_i

        if baby_id == 0 and assistant_id == 0 and status != 0
          if status == 1
            al = ActivityLog.select('activity_logs.*, babies.name as baby_name, assistants.name as assistant_name, activities.name as activity_name')\
                            .joins(:baby, :activity, :assistant)\
                            .order(start_time: :desc)

          elsif status == 2
            al = ActivityLog.select('activity_logs.*, babies.name as baby_name, assistants.name as assistant_name, activities.name as activity_name')\
                            .joins(:baby, :activity, :assistant)\
                            .where.not(stop_time: nil)\
                            .order(start_time: :desc)

          else
            al = ActivityLog.select('activity_logs.*, babies.name as baby_name, assistants.name as assistant_name, activities.name as activity_name')\
                            .joins(:baby, :activity, :assistant)\
                            .where(stop_time: nil).order(start_time: :desc)

          end
        elsif baby_id == 0 and assistant_id != 0 and status == 0
          al = ActivityLog.select('activity_logs.*, babies.name as baby_name, assistants.name as assistant_name, activities.name as activity_name')\
                          .joins(:baby, :activity, :assistant)\
                          .where(assistant_id: assistant_id)\
                          .order(start_time: :desc)

        elsif baby_id == 0 and assistant_id != 0 and status != 0
          if status == 1
            al = ActivityLog.select('activity_logs.*, babies.name as baby_name, assistants.name as assistant_name, activities.name as activity_name')\
                            .joins(:baby, :activity, :assistant)\
                            .where(assistant_id: assistant_id)\
                            .order(start_time: :desc)

          elsif status == 2
            al = ActivityLog.select('activity_logs.*, babies.name as baby_name, assistants.name as assistant_name, activities.name as activity_name')\
                            .joins(:baby, :activity, :assistant)\
                            .where(assistant_id: assistant_id)\
                            .where.not(stop_time: nil)\
                            .order(start_time: :desc)

          else
            al = ActivityLog.select('activity_logs.*, babies.name as baby_name, assistants.name as assistant_name, activities.name as activity_name')\
                            .joins(:baby, :activity, :assistant)\
                            .where(assistant_id: assistant_id, stop_time: nil)\
                            .order(start_time: :desc)

          end
        elsif baby_id != 0 and assistant_id == 0 and status == 0
          al = ActivityLog.select('activity_logs.*, babies.name as baby_name, assistants.name as assistant_name, activities.name as activity_name')\
                            .joins(:baby, :assistant, :activity)\
                            .where(baby_id: baby_id)\
                            .order(start_time: :desc)


        elsif baby_id != 0 and assistant_id == 0 and status != 0
          if status == 1
            al = ActivityLog.select('activity_logs.*, babies.name as baby_name, assistants.name as assistant_name, activities.name as activity_name')\
                            .joins(:baby, :activity, :assistant)\
                            .where(baby_id: baby_id)
                     .order(start_time: :desc)

          elsif status == 2
            al = ActivityLog.select('activity_logs.*, babies.name as baby_name, assistants.name as assistant_name, activities.name as activity_name')\
                            .joins(:baby, :activity, :assistant)\
                            .where(baby_id: baby_id)\
                            .where.not(stop_time: nil)\
                            .order(start_time: :desc)

          else
            al = ActivityLog.select('activity_logs.*, babies.name as baby_name, assistants.name as assistant_name, activities.name as activity_name')\
                            .joins(:baby, :activity, :assistant)\
                            .where(baby_id: baby_id)\
                            .where(stop_time: nil)\
                            .order(start_time: :desc)

          end
        elsif baby_id != 0 and assistant_id != 0 and status != 0
          if status == 1
            al = ActivityLog.select('activity_logs.*, babies.name as baby_name, assistants.name as assistant_name, activities.name as activity_name')\
                            .joins(:baby, :activity, :assistant)\
                            .where(baby_id: baby_id, assistant_id: assistant_id)\
                            .order(start_time: :desc)

          elsif status == 2
            al = ActivityLog.select('activity_logs.*, babies.name as baby_name, assistants.name as assistant_name, activities.name as activity_name')\
                            .joins(:baby, :activity, :assistant)\
                            .where(baby_id: baby_id, assistant_id: assistant_id).where.not(stop_time: nil)\
                            .order(start_time: :desc)

          else
            al = ActivityLog.select('activity_logs.*, babies.name as baby_name, assistants.name as assistant_name, activities.name as activity_name')\
                            .joins(:baby, :activity, :assistant)\
                            .where(baby_id: baby_id, assistant_id: assistant_id, stop_time: nil)\
                            .order(start_time: :desc)

          end
        end
      end
      format.json {render json: {'activities' => al}}
    end

  end
end
