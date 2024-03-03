Rails.application.routes.draw do
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }do
    get 'customers/sign_up' => 'public/registrations#new', as: 'new_customer_registration'
    post 'customers/sign_up' => 'public/registrations#create', as: 'customer_registration'
  end
  
  devise_scope :customer do
    post 'guest_sign_in' => 'public/sessions#guest_sign_in'
  end
  
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  
  scope module: :public do
    get '/' => 'homes#top', as: 'public_top'
    get '/access' => 'homes#access'
    
    get '/my_page' => 'customers#show'
    get '/information/edit' => 'customers#edit'
    patch '/information' => 'customers#update'
    get '/unsubscribe' => 'customers#unsubscribe'
    patch '/withdraw' => 'customers#withdraw'
  end
  
  namespace :admin do
    get '/' => 'homes#top'
    get '/search' => 'customers#search'
    resources :customers, only: [:index, :show, :edit, :update]
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
