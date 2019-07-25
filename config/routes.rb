Rails.application.routes.draw do
  root 'subscribers#index'
  
  resources :subscribers do
    collection { get 'download_pdf' }
    collection { get 'download_csv' }
    collection { get 'sendMail' }
  end
  resources :posts
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
