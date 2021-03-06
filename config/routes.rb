Rails.application.routes.draw do
  
  mount Ckeditor::Engine => '/ckeditor'
  resources :donations
  resources :cases do 
    member do 
      get "accept"
      get "reject"
      get "manager"
      get "close"
      get "details"
      delete "unarchive"
    end
    get :autocomplete_problem_name, :on => :collection
    get :autocomplete_treatment_name, :on => :collection
    post :update_row_order, on: :collection

    resources :disbursments
    resources :requests
  end

  get '/reports' => 'welcome#index'

  devise_for :users, :skip => [:sessions]
  as :user do
    get '/login' => 'devise/sessions#new', :as => :new_user_session
    post '/login' => 'devise/sessions#create', :as => :user_session
    delete '/logout' => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  resources :admins
  resources :users, controller: "users"
  resources :doctors

  post "/comments" => "comments#create"

  delete "/comments/:id" => "comments#destroy"

  get "/profile" => "users#profile"

  post "/caseReports" => "welcome#cases"
  post "/donationReports" => "welcome#donations"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'cases#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
