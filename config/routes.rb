Rails.application.routes.draw do
  
  
  devise_for :authors
  scope module: 'authors' do
    patch 'publish/:id', to: 'posts#publish', as: 'publish'
    patch 'unpublish/:id', to: 'posts#unpublish', as: 'unpublish'
    resources :posts do
      resources :elements
    end
  end
  
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
