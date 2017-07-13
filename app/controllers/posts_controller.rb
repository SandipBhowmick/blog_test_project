class PostsController < ApplicationController
	layout "post"
	add_breadcrumb "home", :root_path
	before_action :store_return_to
	before_action :confirm_logged_in,:except => [:index, :show] 

	def index
		@posts= Post.all().order('created_at ASC')
	end


	

	def new
		@post = Post.new()
	end


	def create
		@post = Post.new(post_params)
		@post.user_id= session[:current_user_id]
		# abort("test")

		if @post.save
			flash[:notice]= "Post successfull."
			redirect_to posts_path 
		else
			flash[:notice]= "something wrong."
			render :new
		end 
	end


	def edit
		@post= Post.find(params[:id])
	end


	def update
		@post= Post.find(params[:id])
		if @post.update_attributes(post_params)
			flash[:notice]= "post updated successfully."
			redirect_to posts_path
		else
			flash[:notice] = "something wrong."
			render 'edit'
		end 
	end

	def soft_publish
		post = Post.find(params[:id])
		post.update_attributes(publish: false)
		flash[:notice]= "Post '#{post.title}' un-publish successfully."
		redirect_to posts_path
	end

	def soft_unpublish
		post = Post.find(params[:id])
		post.update_attributes(publish: true)
		flash[:notice]= "Post '#{post.title}' publish successfully."
		# byebug
		redirect_to posts_path
	end


	def destroy
		post = Post.find(params[:id]).destroy
		flash[:notice]= "Post '#{post.title}' destroyed successfully."
		redirect_to posts_path
	end

	def show
		  # abort(params.inspect)
		if (params[:id]==nil && params[:post_id])
			@post= Post.find(params[:post_id])
		else
			@post= Post.find(params[:id])
		end
		
	end


	
	def is_admin?(user)


		user = User.find_by_id(user)
		if(user!= nil)
			user.is_admin
		else
			false
		end
	end
	helper_method :is_admin?

	private

		def post_params

			params.require(:post).permit(:title,:body,:user_id,:deleted_at)
	
		end


end
