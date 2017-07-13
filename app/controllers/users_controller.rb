class UsersController < ApplicationController
	layout "user"
	add_breadcrumb "home", :root_path
	# before_action :confirm_logged_in, :except => [:home,:new,:create,:get_states,:index, :show, :follow_details]
	before_action :store_return_to
	before_action :confirm_logged_in_as_admin, :only =>[:approve_users]
	before_action :confirm_logged_in, :only =>[:follow_user, :unfollow_user]
	

	def home
		@user=User.new()
	end

	def index
		@users=User.all().order('first_name ASC')

	end
	

	def show		
		@user = User.find(params[:id])
		@country = @user.country
		@state = @user.state
		@follow=Follow.new()
	end

	def new
		@user=User.new()		
		if (params[:state_id])
			@user_state_id = params[:state_id]			
		end		
	end

	def create		 
		@user=User.new(user_params)
		if @user.save
			flash[:notice]= "User registration successfully."
			redirect_to user_login_path 
		else
			@state_js = params[:user][:state_id]
			render :new
		end 
	end

	def get_states
		states = State.where('country_id = ?', params[:id]).order('state_name ASC')
		result = {'res' => states, 'message' => 'All states.'}		
		render json: result, status: 200
	end

	def follow_user
		followee = params[:followee]
		followers= params[:followers]
		@follow=Follow.new()
		user = User.find_by(:id => followee)
		if(session[:current_user_id]!= nil)
			@follow.follower_id = followers
			@follow.user_id = followee
			if(user.follow_count)	
				user.update_attributes(:follow_count => user.follow_count + 1 )
			else 
				user.update_attributes(:follow_count => 1 )
			end

			if @follow.save
				flash[:notice]= " Thank you for follow the user."
				redirect_to users_path 
			else
				flash[:notice]= "something wrong"			
				redirect_to users_path
			end
		else 
			flash[:notice]= " Please log in first."
			redirect_to user_login_path
		end
	end



	def unfollow_user		
		followee = params[:followee]
		followers= params[:followers]		

		if(session[:current_user_id]!=nil)
			user = User.find_by(:id => followee)
			@follow=Follow.where(:user_id => followee,:follower_id => followers).first
			
			if(user.follow_count)	
				user.update_attributes(:follow_count => (user.follow_count - 1) )
			end

			if @follow.destroy
				flash[:notice]= " you are no longer follow the user."
				redirect_to users_path 
			else
				flash[:notice]= "something wrong"			
				redirect_to users_path
			end
		else 
			flash[:notice]= " Please log in first."
			redirect_to users_path
		end
	end

	def approve_users
		# abort(request.url)
		@users_approve = User.where(:is_admin => false, :is_approve => true).order('email ASC')
		@users_disapprove = User.where(:is_admin => false, :is_approve => false).order('email ASC')
	end

	def make_approve
		user = User.find_by_id(params[:id])
		user.update_attributes(:is_approve => true )
		redirect_to approve_users_users_path
		
	end

	def make_disapprove
		user = User.find_by_id(params[:id])
		user.update_attributes(:is_approve => false )
		redirect_to approve_users_users_path
	end



	def follow_details
		@user = User.find(params[:id])
		loged_in_user =session[:current_user_id]
		follow=Follow.where(:follower_id =>loged_in_user,:user_id =>@user.id ).first
	end
	helper_method :follow_details





	private
	def user_params		
		params[:user][:interest]=(params[:user][:interest]).to_json		
		params.require(:user).permit(:first_name, :last_name, :gender, :country_id, :state_id, :interest, :address, :email, :password, :profile_image,:password_confirmation, :is_approve)
	end
end
