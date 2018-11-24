Rails.application.routes.draw do
  post '/sensor/register', to: "sensor#register"
  post 'sensor/update', to: "sensor#update"
  post '/sensor_detail', to: "sensor#details"
  post '/sensor/config', to: "sensor#configuration"
  post '/transporte_details', to: "sensor#transporte_details"
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#index'
  mount ActionCable.server => '/cable'
end

