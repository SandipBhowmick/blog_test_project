Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'
  root 'users#home'

   # get 'users/new' => 'users#new', as: 'new_user_registration' 
   # post 'users/create' => 'users#create'
    resources :users do 
      collection do
        get 'approve_users'
      end
      
      member do
        get 'get_interest'
        post 'change_password'
        get 'password'
        post 'make_disapprove'
        post 'make_approve'
      end 
    end
    resources :posts do
      resources :comments, except: [:index,:show]
      # resources :comments do
      #    get '/posts/:post_id/comments(.:format)', to: 'posts#show'        
      # end
    end

    resources :post_details
      
   

    resources :categories
  
    # resources :users do
    #   resources :categories, only: [:index, :new, :create]
    # end

    # resources :access do 
    #   get 'logout', on: :member
    #   get 'login'
    #   post 'attempt_login', on: :member
      
    # end

    get 'access/logout' => 'access#logout'
    get 'access/login' => 'access#login', as: 'user_login'
    get 'access/index' => 'access#index', as: 'user_menu'
    get 'get_states' => 'users#get_states', as: 'get_states'
    delete 'new_bulk_delete' => 'bulk_delete#delete', as: 'new_bulk_delete' 

    post 'access/attempt_login' => 'access#attempt_login'
    post 'follow_user' => 'users#follow_user', as: 'follow_user'
    post 'unfollow_user' => 'users#unfollow_user', as: 'unfollow_user'
    post 'posts/soft_publish/:id(.:format)' => 'posts#soft_publish', as: 'posts_soft_publish'
    post 'posts/soft_unpublish/:id(.:format)' => 'posts#soft_unpublish', as: 'posts_soft_unpublish'

    post 'posts/comments/soft_publish/:id(.:format)' => 'comments#soft_publish', as: 'posts_comments_soft_publish'
    post 'posts/comments/soft_unpublish/:id(.:format)' => 'comments#soft_unpublish', as: 'posts_comments_soft_unpublish'
    get '/posts/:post_id/comments(.:format)' => 'posts#show'
    get 'follow_user(.:format)' => 'users#index'


    get 'access/api_log_in' => 'access#api_log_in', as: 'api_log_in'
    # get 'users/api_log_in' => 'users#api_log_in', as: 'api_log_in_users'
    # match ':controller(/:action(/:id))', :via => [:get, :post]
    resources :access
    # resources :categories
    # get 'categories/index' => 'categories#index'
     
    # post 'categories/new_category' => 'categories#create'
    # get 'categories/new_category' => 'categories#new', as: 'new_category'
    #match ':controller(/:action(/:id))', :via => [:get, :post]
    #post 'create' => 'users#create'
    #match ':controller/:action/:id', via: [:get, :post]
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
