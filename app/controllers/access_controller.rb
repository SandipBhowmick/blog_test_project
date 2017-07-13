class AccessController < ApplicationController
  layout "access"
  
  # before_action :store_return_to 

  # before_action :confirm_logged_in, :except => [:index,:login, :attempt_login, :logout]

  add_breadcrumb "home", :root_path

  def index
  	#display text & links

  end

  def login
  	# login form 
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end



  def attempt_login
	if params[:email].present? && params[:password].present?
      found_user = User.where(:email => params[:email]).first
      if found_user
        # abort(params[:password])
        # abort()
        authorized_user = found_user.authenticate(params[:password])
        # if (found_user.password == params[:password])
        #   authorized_user = found_user
        # end
      end
    end
    if authorized_user  
      if authorized_user.is_approve   
        session[:email] = authorized_user.email
        session[:current_user_id] = authorized_user.id
        flash[:notice] = "You are now logged in."
        redirect_back_or_default(root_path)
      else
         flash[:notice] = "Admin approval is pending. Please contact admin."
        redirect_to(:action => 'login')
      end
    else
      flash[:notice] = "Invalid email/password combination."
      redirect_to(:action => 'login')
    end
  end

  def logout
    # mark user as logged out
    session[:email] = nil 
    session[:current_user_id] = nil  
  	flash[:notice] = "Logged out"
  	redirect_to(:action => "login")
  end   
end