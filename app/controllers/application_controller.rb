class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  
  


  private 

  def store_return_to
    session[:return_to] = request.url
  end

  def confirm_logged_in

    # if(session[:return_to])
    #   abort(session[:return_to].to_json)
    # end
    
    unless session[:email]
      flash[:notice]= 'Please log in.'+ ''
      redirect_to(:controller=>'access', :action => 'login')
      return false # halts the before_action
    else
      return true
    end
  end

  def confirm_logged_in_as_admin
    session[:return_to]=request.url
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

