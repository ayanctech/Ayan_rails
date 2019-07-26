Rails.application.routes.draw do
  root 'subscribers#index'
  
  resources :subscribers do
    collection { get 'download_pdf' }
    collection { get 'download_csv' }
    collection { get 'sendMail' }
  end
  resources :posts
  resources :users
end
