Rails.application.routes.draw do

  root 'users#home'
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
        collection do
        match 'search' => 'posts#search', via: [:get, :post], as: :search
      end      
      resources :comments, except: [:index,:show]      
    end

    resources :post_details
    resources :categories
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
    get 'get_sub_category(.:format)' => 'posts#get_sub_category', as: 'get_sub_category'

    resources :access   
end
