# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  # create account page
  get "create_account", to: "create_account#index", as: :create_account
  # privacy page
  get "privacy", to: "privacy#index", as: :privacy

  # get the admin root
  get "admin", to: "admin#admin", as: :admin
  # Update action for update note for lead through admin dashboard
  patch "/admin/update_lead/:id", to: "admin#update_lead", as: :admin_update_lead
  # Delete action for the destroy newsletter
  delete "/admin/destroy_newsletter/:id", to: "admin#destroy_newsletter", as: :admin_destroy_newsletter
  # Delete action for the destroy lead
  delete "/admin/destroy_lead/:id", to: "admin#destroy_lead", as: :admin_destroy_lead

  # Post action for the contact form in landing controller
  post "/landing/lead", to: "landing#create_lead", as: :create_lead
  # Post action for the newsletter form in landing controller
  post "/landing/newsletter", to: "landing#create_newsletter", as: :create_newsletter

  devise_for :users

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "landing#index"
end
