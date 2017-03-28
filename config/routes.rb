Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home_page#index'
  resources :home_page do
    collection do
      get 'load_more'
    end
  end
end
