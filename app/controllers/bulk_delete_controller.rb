class BulkDeleteController < ApplicationController
	def delete		  
	  if params[:category_ids].is_a?(Array) && params[:category_ids].length > 0  #let's make sure we got what we expected
		Category.where(:id => params[:category_ids]).destroy_all
	    redirect_to user_login_path
	  else
	    redirect_to user_login_path
	  end
	end
end