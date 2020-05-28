class Api::BabiesController < ApiController
  def index
    if request.get?
      babies = Baby.select(:id, :name, :birthday, :mother_name, :father_name, :address, :phone)
      babies_list = Array.new
      babies.each do |baby|
        baby_hash = Hash.new
        baby_age = "#{age_in_months(baby.birthday)} #{' months'}"

        baby_hash['name'] = baby.name
        baby_hash['baby_age'] = baby_age
        baby_hash['mother_name'] = baby.mother_name
        baby_hash['father_name'] = baby.father_name
        baby_hash['address'] = baby.address
        baby_hash['phone'] = baby.phone
        babies_list << baby_hash
      end
      render json: {status: 'Success', message: 'Loaded all babies', data: babies_list}, :status => :ok
    else
      render json: {status: 'Error', message: 'Method not allowed'}, :status => :method_not_allowed
    end

  rescue Exception => exc
    render json: {status: 'Exception', message: 'An exception occurred'}, :status => :internal_server_error
  end

  def get_activity_log
    if request.get?
      if params[:id].present? and !params[:id].blank? and params[:id].to_i.is_a? Integer
        id = params[:id]
        babies = ActivityLog.select('activity_logs.id, activity_logs.baby_id, activity_logs.activity_id, assistants.name as assistant_name, activity_logs.start_time, activity_logs.stop_time')\
                           .joins(:baby, :activity, :assistant)\
                           .where(baby_id: id)
        if babies.blank?
          render json: {status: 'No content', message: 'There are no entries for this id'}, :status => :bad_request
        else
          babies.each do |baby|
            baby.start_time = baby.start_time.in_time_zone.iso8601
            if baby.stop_time.nil?
              baby.stop_time = nil
            else
              baby.stop_time = baby.stop_time.in_time_zone.iso8601
            end
          end
          render json: {status: 'Success', message: 'Loaded baby logs.', data: babies}, :status => :ok
        end
      else
        render json: {status: 'Error', message: 'Please check the parameters.'}, :status => :bad_request
      end

    else
      render json: {status: 'Error', message: 'Method not allowed'}, :status => :method_not_allowed
    end
  rescue Exception => exc
    render json: {status: 'Exception', message: 'An exception occurred.'}, :status => :internal_server_error
  end

  private
  def age_in_months(birthday)
    time_now = Time.now.strftime('%Y-%m-%d')
    d1 = time_now.to_time
    d2 = birthday.to_time

    age_months = (d1.year * 12 + d1.month) - (d2.year * 12 + d2.month)
    return age_months
  end
end
