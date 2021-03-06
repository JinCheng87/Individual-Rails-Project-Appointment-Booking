Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  root to:'home#index'

  get '/admin', to: 'admin#index'
  get '/users/appointments', to: 'appointments#customer_appointments', as:'customer_appointments'
  get '/stores/:store_id/staffs/:id/appointments', to: 'appointments#staff_appointments', as: 'staff_appointments'
  get 'admin/stores/:store_id/schedule/:id', to:'admin#show_calendars', as: 'store_schedule'
  get 'admin/employees', to:'admin#show_employees',as: 'show_empolyees'
  get 'admin/appointments', to:'admin#show_appointments', as: 'show_appointments'
  get 'admin/stores_hours', to:'admin#show_stores_hours', as: 'show_stores_hours'
  get 'admin/services', to:'admin#show_services', as: 'show_services'
  post '/stores/:store_id/staffs/:id/blocktime', to: 'block_times#create', as: 'new_block_time'
  delete '/stores/:store_id/staffs/:id/blocktime', to: 'block_times#destroy',as: 'delete_block_time'
  resources :services
  resources :stores, except: [:new, :create, :destroy] do
    resources :appointments, except: [:index]
    resources :staffs
  end

  get '*unmatched_route', to: 'application#not_found'
end
