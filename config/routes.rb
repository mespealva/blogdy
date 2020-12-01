Rails.application.routes.draw do
  
  get "blog/:id", to: 'readers/posts#show', as:'blog_post'
  devise_for :authors, controllers: { omniauth_callbacks: 'authors/omniauth_callbacks' }
  #devise_scope :author do
  #  get 'authors/sign_in', to: 'authors/sessions#new', as: :new_author_session
  #  get 'authors/sign_out', to: 'authors/sessions#destroy', as: :destroy_author_session
  #end
  
  
  scope module: 'authors' do
    get 'stats', to: "stats#index"
    get 'posted', to: "posts#posted", as:"posted"
    get 'finised', to: "posts#finished", as:"finished"
    get 'unposted', to: 'posts#unposted', as: "unposted"
    patch 'publish/:id', to: 'posts#publish', as: 'publish'
    patch 'unpublish/:id', to: 'posts#unpublish', as: 'unpublish'
    patch 'finish/:id', to: 'posts#finish', as: 'finish'
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
