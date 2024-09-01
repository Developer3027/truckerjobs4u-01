Rails.application.routes.draw do
  devise_for :users

  # Post action for the contact form in landing controller
  post "/landing/lead", to: "landing#create_lead"

  # Post action for the newsletter form in landing controller
  post "/landing/newsletter", to: "landing#create_newsletter"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "landing#index"
end
