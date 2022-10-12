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

    devise_scope :user do
      post 'users/guest_sign_in', to: 'sessions#guest_sign_in'
    end
  end



end
