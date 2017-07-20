class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception 


  before_action :login_or_not


  private 

  def login_or_not
    if(session[:current_user_id])
      confirm_logged_in
    end
  end

  def encode_system_details
    system_detail = request.user_agent + request.ip
    enc_system_detail = Base64.encode64(system_detail)
  end

  def store_return_to
    session[:return_to] = request.url
  end

  def confirm_logged_in
    user_session = UserSession.find_by_user_id(session[:current_user_id])
    unless user_session
      flash[:notice]= 'Please log in.'+ ''
      session[:email] = nil
      session[:current_user_id] = nil
      redirect_to(:controller=>'access', :action => 'login')
      return false # halts the before_action
    else
      if(user_session.system_detail!= encode_system_details )
        flash[:notice]= 'Please log in.'+ ''
        session[:email] = nil
        session[:current_user_id] = nil
        redirect_to(:controller=>'access', :action => 'login')
        return false
      else
        return true
      end
    end
  end

  def confirm_logged_in_as_admin
    store_return_to
    user_session = UserSession.find_by_user_id(session[:current_user_id])
    if(!user_session)
      session[:email] = nil
      session[:current_user_id] = nil
    else 
      if(user_session.system_detail!= encode_system_details)
        session[:email] = nil
        session[:current_user_id] = nil
      end
    end

    user = User.find_by_id(session[:current_user_id])
    if(user!=nil)
      if(!user.is_admin?)
        flash[:notice1]= 'Please log in as admin.'
        redirect_to(:controller=>'access', :action => 'login')
        return false # halts the before_action
      else
        return true
      end
    else
      flash[:notice1]= 'Please log in as admin.'
      redirect_to(:controller=>'access', :action => 'login')
      return false
    end
  end

end

