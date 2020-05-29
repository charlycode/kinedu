class Api::ApiActivityLogsController < ApiController
  def create_entry
    if request.post?
      data, check = check_params(params)
      if check
        activity = ActivityLog.new
        activity.baby_id = params[:baby_id]
        activity.assistant_id = params[:assistant_id]
        activity.activity_id = params[:activity_id]
        activity.start_time = Time.now.in_time_zone.iso8601

        if activity.save!
          entry = Hash.new
          entry['id'] = activity.id
          entry['baby_id'] = activity.baby_id
          entry['assistant_id'] = activity.assistant_id
          entry['activity_id'] = activity.activity_id
          entry['start_time'] = activity.start_time

          render json: {status: 'Success', message: 'Create activity log.', data: entry}, :status => :created
        else
          render json: {status: 'Exception', message: 'An exception occurred.'}, :status => :internal_server_error
        end
      else
        render json: data, :status => :bad_request
      end
    else
      render json: {status: 'Error', message: 'Method not allowed'}, :status => :method_not_allowed
    end
  rescue Exception => exc
    render json: {status: 'Exception', message: 'An exception occurred.'}, :status => :internal_server_error
  end

  def finished_entry
    if request.put?
      if params[:id].present? and !params[:id].blank? and params[:id].to_i.is_a? Integer
        id = params[:id]
        logger.debug "#{'ID: '}#{id}"
        activity = ActivityLog.find_by(id: id)
        logger.debug "#{'ACTIVITY: '}#{activity.inspect}"
        if !activity.blank?
          if params[:comments].present? and !params[:comments].blank?
            comments = params[:comments]
          else
            comments = ''
          end
          if activity.stop_time.blank?
            activity.stop_time = Time.now.in_time_zone.iso8601
            activity.comments = comments
            start = activity.start_time.to_time
            stop = activity.stop_time.to_time

            total = stop - start
            total = (total / 60).to_i
            activity.duration = total

            if activity.update(stop_time: activity.stop_time, comments: activity.comments)
              entry = Hash.new
              entry['id'] = activity.id
              entry['duration'] = "#{activity.duration} #{' minutes'}"
              render json: {status: 'Success', message: 'Update activity log.', data: entry}, :status => :ok
            else
              render json: {status: 'Exception', message: 'An exception occurred.'}, :status => :internal_server_error
            end
          else
            render json: {status: 'Info', message: 'Previously completed activity'}, :status => :accepted
          end

        else
          render json: {status: 'No content', message: 'The id parameter is wrong, there is no data.'}, :status => :bad_request

        end

      else
        render json: {status: 'Error', message: 'Please check the parameters.'}, :status => :bad_request

      end
    else
      render json: {status: 'Error', message: 'Method not allowed'}, :status => :method_not_allowed
    end
  rescue Exception => exc
    logger.debug "#{'EXCEPTION: '}#{exc.backtrace.to_s}"
    render json: {status: 'Exception', message: 'An exception occurred.', Exception: exc.to_s}, :status => :internal_server_error
  end

  private

  def check_params(params)
    data = Hash.new
    if params[:baby_id].present? and !params[:baby_id].blank? and params[:baby_id].to_i.is_a? Integer
      baby = Baby.find_by(id: params[:baby_id])
      if baby.blank?
        data['status'] = 'No content'
        data['message'] = 'The baby_id parameter is wrong, there is no data.'
        check = false
        return data, check
      end
    else
      data['status'] = 'Error'
      data['message'] = 'The baby_id parameter must be present'
      check = false
      return data, check
    end

    if params[:assistant_id].present? and !params[:assistant_id].blank? and params[:assistant_id].to_i.is_a? Integer
      assistant = Assistant.find_by(id: params[:assistant_id])
      if assistant.blank?
        data['status'] = 'Error'
        data['message'] = 'The assistant_id parameter is wrong, there is no data.'
        check = false
        return data, check
      end
    else
      data['status'] = 'Error'
      data['message'] = 'The assistant_id parameter must be present'
      check = false
      return data, check
    end

    if params[:activity_id].present? and !params[:activity_id].blank? and params[:activity_id].to_i.is_a? Integer
      activity = Activity.find_by(id: params[:activity_id])
      if activity.blank?
        data['status'] = 'Error'
        data['message'] = 'The activity_id parameter is wrong, there is no data.'
        check = false
        return data, check
      end
    else
      data['status'] = 'Error'
      data['message'] = 'The activity_id parameter must be present'
      check = false
      return data, check
    end
    check = true
    return data, check
  end
end