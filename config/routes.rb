Rails.application.routes.draw do
  get "blog/:id", to: 'readers/posts#show', as:'blog_post'
  devise_for :authors
  scope module: 'authors' do
    patch 'publish/:id', to: 'posts#publish', as: 'publish'
    patch 'unpublish/:id', to: 'posts#unpublish', as: 'unpublish'
    resources :posts do
      resources :elements do
        member do
          patch :move
        end
      end
    end
  end
  
  root 'readers/home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
