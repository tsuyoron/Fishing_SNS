Rails.application.routes.draw do
# 管理者用
# URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    get 'top' => 'homes#top', as: 'top'
  end

# 会員用
# URL /users/sign_in ...
  devise_for :users,skip: [:passwords], controllers: {
    sessions: 'public/sessions',
    registrations: 'public/registrations',
  }

  scope module: :public do
    root 'homes#top'
    get 'about'=>'homes#about' ,as:'about'

    get 'users/mypage/:id' => 'users#show', as: 'mypage'

    # users/editのようにするとdeviseのルーティングとかぶってしまうためinformationを付け加えている。
    get 'users/information/edit/:id' => 'users#edit', as: 'edit_information'
    patch 'users/information' => 'users#update', as: 'update_information'

    resources :catches, only: [:index,:show,:edit,:create,:destroy,:update] do
      resource :favorites, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end

    devise_scope :user do
      post 'users/guest_sign_in', to: 'sessions#guest_sign_in'
    end
  end

end
