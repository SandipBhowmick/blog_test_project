class AccessController < ApplicationController
  layout "access"
  
  # before_action :store_return_to 

  # before_action :confirm_logged_in, :except => [:index,:login, :attempt_login, :logout]

  
  def index
  	#display text & links
     # @ = session[:current_user_id]

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
        # u = UserSession.find_by_id(authorized_user.id)
        session[:email] = authorized_user.email
        session[:current_user_id] = authorized_user.id       

        if(!UserSession.find_by_user_id(authorized_user.id))
          UserSession.new(:user_id => authorized_user.id, :system_detail => encode_system_details).save          
          # cookies[:current_user_id] = authorized_user.id
          flash[:notice] = "You are now logged in."
          # byebug
          redirect_back_or_default(root_path)
        else
          user_session =UserSession.find_by_user_id(authorized_user.id)
          if (user_session.system_detail != encode_system_details)
            user_session.update_attributes(:system_detail => encode_system_details)
            redirect_back_or_default(root_path)
          else
            redirect_back_or_default(root_path)
          end

        end
      else
         flash[:notice] = "Admin approval is pending. Please contact admin."
        redirect_to(:action => 'login')
      end
    else
      # session[:current_user_id] = 20
      # session[:email] = "abcdef@email.com"
      flash[:notice] = "Invalid email/password combination."
      redirect_to(:action => 'login')
    end
  end

  def logout
    # mark user as logged out
    # byebug
    # byebug
    session[:email] = nil 
    UserSession.find_by_user_id(session[:current_user_id]).destroy    
    session[:current_user_id] = nil 
    session[:return_to] = nil

    if(params[:authorized])
      flash[:authorized] = params[:authorized]
    end
    flash[:notice] = "Logged out"
  	redirect_to(:action => "login")
  end   

  def api_log_in
    # abort(params.to_json)
    if session[:current_user_id]
      result = {'res' => session[:current_user_id], 'message' => 'Log in state.'} 
    else
      result = {'res' => nil, 'message' => 'Log in state.'}
    end
    render json: result, status: 200        
  end

end