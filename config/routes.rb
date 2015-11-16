Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions" }

  mount Ckeditor::Engine => '/ckeditor'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  post ":locale/contact_feedback", as: :contact_feedback, to: "pages#contact_feedback"
  post ":locale/order", to: "pages#order"

  get "(:locale)", to: "pages#home"
  Cms.load_routes

  # scope "(:locale)" do
  #   resources :services, only: [:show, :index]
  #   resources :articles, only: [:show, :index]
  # end

  localized do
    resources :services, only: [:show, :index], defaults: { localized: true, route_name: :services }
    resources :articles, only: [:show, :index], defaults: { localized: true, route_name: :articles }
  end




  get "*url", to: "errors#not_found", as: :not_found

  get "/admin/*url", as: :admin, to: "application#admin"


end
