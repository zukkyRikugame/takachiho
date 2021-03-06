Rails.application.routes.draw do
  devise_for :users

  authenticate :user do
    get 'dashboard' => 'pages#dashboard'
    get 'dashboard-stat1' => 'pages#dashboard_stat1'

    get 'tmpr_logs/graph/:raspi_id' => 'tmpr_logs#graph', as: :tmpr_logs_graph
    get 'tmpr_logs/graph_data'

    resources :settings
    resources :addresses
    resources :tmpr_monthly_logs
    resources :tmpr_daily_logs
    resources :tmpr_logs

    get 'users' => 'users#index'
    get 'login-as' => 'users#login_as'
    get 'logs/last_timestamp' => 'tmpr_logs#last_timestamp'
    get 'send_testmail' => 'addresses#send_testmail'
    get 'send_testcall' => 'addresses#send_testcall'
  end
  get 'logs/insert' => 'tmpr_logs#insert'

  get 'about' => 'pages#about'
  get 'howto' => 'pages#howto'
  get 'usecase' => 'pages#usecase'

  root 'pages#root'
end
