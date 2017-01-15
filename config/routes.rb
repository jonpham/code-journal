Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_scope :user do
    authenticated :user do
      root 'lessons#index', as: :authenticated_root # Should be User Dashboard
    end

    unauthenticated do
      root 'statics#index', as: :unauthenticated_root
    end
  end
  # Add Resources for Controllers
  resources :lesson_categories, :lessons, :lesson_modules, :module_codes, :test_codes
end
