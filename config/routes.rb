# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  get 'users/dashboard'

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

  # Root route for advisor
  authenticated :user, lambda { |u| u.role == "advisor" } do
    root to: "advisor#index", as: :advisor
  end

  # Root route for user
  authenticated :user, lambda { |u| u.role == "user" } do
    root to: "users#dashboard", as: :user
  end

  # Route to show user address form
  get "address", to: "users#address", as: :address
  # Route to create user address
  post "create_address", to: "users#create_address", as: :create_address

  # Route to show user license form
  get "license", to: "users#license", as: :license
  # Route to create user license
  post "create_license", to: "users#create_license", as: :create_license

  # get the blog general root
  get "blog", to: "blog#index", as: :blog
  # get the single blog - show
  get "/blog/:id", to: "blog#show", as: :blog_show

  # Route for new blog
  get "new_blog", to: "advisor#new_blog", as: :advisor_new_blog
  # Route for list of blogs
  get "list_blogs", to: "advisor#list_blogs", as: :advisor_list_blogs
  # Route for edit blog
  get "edit_blog/:id", to: "advisor#edit_blog", as: :advisor_edit_blog
  # create blog through advisor dashboard
  post "create_blog", to: "advisor#create_blog", as: :advisor_create_blog
  # update blog through advisor dashboard
  patch "update_blog/:id", to: "advisor#update_blog", as: :advisor_update_blog
  # delete blog through advisor dashboard
  delete "destroy_blog/:id", to: "advisor#destroy_blog", as: :advisor_destroy_blog
  # delete cover image through advisor dashboard
  resources :blog do
    resources :cover_images, only: [:destroy], module: :blog
  end

  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
  }

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "landing#index"
end
