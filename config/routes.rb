Rails.application.routes.draw do
  root 'activity_logs#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/get_activities_log' , to: 'activity_logs#get_activities_log', as: 'get_activities_log_path'
end
