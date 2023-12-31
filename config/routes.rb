Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  get '/static/data_export', to: 'static_pages#data_export'

  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do

    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

    # Defines the root path route ("/")
    root "people#index"
    get 'apropos', to: 'static_pages#apropos'
    get 'detail', to: 'static_pages#detail'
    get 'imprint', to: 'static_pages#imprint'
    get 'privacy', to: 'static_pages#privacy'

    resources :people, only: [:index, :show], param: :slug, constraints: { slug: /(?!new$)[\w-]+/ } do
      collection do
        post 'filter_cantons'
        get 'get_canton_filter'
        post 'filter_parties'
        get 'get_party_filter'
        get :load_more
      end
    end


  end

end
