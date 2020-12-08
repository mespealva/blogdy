
Rails.application.routes.draw do
  
  
  get "blog/:id", to: 'readers/posts#show', as:'blog_post'
  get 'mujeres-olvidadas', to: 'readers/home#mujeres', as: "mujeres"
  get 'opinion', to: 'readers/home#opinion', as: "opinion"
  get 'investigacion', to: 'readers/home#research', as:'research'
  get 'quienes-somos', to: 'readers/home#team', as: 'team'
  get 'difusion', to:'readers/home#difusion', as: 'difusion'
  
  devise_for :authors, controllers: { omniauth_callbacks: 'authors/omniauth_callbacks',
                                      sesions: 'authors/sesions' }

  scope module: 'authors' do
    delete 'destroy', to:'users#destroy'
    get 'authors', to: 'users#index', as: 'authors'
    get 'stats', to: "stats#index"
    get 'posted', to: "posts#posted", as:"posted"
    get 'finished', to: "posts#finished", as:"finished"
    get 'unposted', to: 'posts#unposted', as: "unposted"
    get 'comentados', to: 'posts#comments', as: 'comments'
    patch 'publish/:id', to: 'posts#publish', as: 'publish'
    patch 'unpublish/:id', to: 'posts#unpublish', as: 'unpublish'
    patch 'finish/:id', to: 'posts#finish', as: 'finish'
    resources :posts do
      member do
        put 'like', to: 'posts#like', as: "like"
      end
      resources :elements do
        member do
          patch :move
        end
      end
    end
  end
  
  root 'readers/home#index'

end
