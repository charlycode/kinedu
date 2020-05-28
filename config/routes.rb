Rails.application.routes.draw do
  root 'activity_logs#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/get_activities_log', to: 'activity_logs#get_activities_log', as: 'get_activities_log_path'

  namespace :api, defaults: { format: :json } do
      match '/babies', to: 'babies#index', via: [:get, :post, :put, :patch, :options, :delete]
      match '/babies/:id/activity_logs', to: 'babies#get_activity_log', via: [:get, :post, :put, :patch, :options, :delete]
      match '/activities', to: 'activities#index', via: [:get, :post, :put, :patch, :options, :delete]
  end
end
