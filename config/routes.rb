Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'statics#index'

  # Add Resources for Controllers
  resources :lesson_categories
end
