class Api::ActivitiesController < ApiController
  def index
    if request.get?
      activities = Activity.select(:id, :name, :description )
      render json: {status: 'Success', message: 'Loaded all activities', data: activities}, :status => :ok
    else
      render json: {status: 'Error', message: 'Method not allowed'}, :status => :method_not_allowed
    end

  rescue Exception => exc
    render json: {status: 'Exception', message: 'An exception occurred'}, :status => :internal_server_error
  end
end