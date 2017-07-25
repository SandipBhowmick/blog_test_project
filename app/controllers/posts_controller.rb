class PostsController < ApplicationController

	layout "post"
	
	before_action :store_return_to
	before_action :confirm_logged_in,:except => [:index, :show] 
	
	def search 
		index    
		render :index
    end

	def index		
		@posts = Post.all.order('created_at DESC')
		@categories = []
		@posts.each do |p|
			@categories.push(find_category_all(p))
		end
		@categories = @categories.uniq
		@q = Post.ransack(params[:q])
		@posts = @q.result(distinct: true).order('created_at DESC')		
	end

	def find_category_all(post)		
		category = Category.find(post.category_id)
		category		
	end
	helper_method :find_category_all

	def find_category_name(post)		
		category = Category.find(post.category_id)
		if(category.parent_id == nil)
			category.name
		else
			category = Category.find(category.parent_id)
			category.name
		end		
	end
	helper_method :find_category_name

	def find_sub_category_name(post)
		category = Category.find(post.category_id)
		if(category.parent_id != nil)
			category.name
		else
			return ""
		end

	end
	helper_method :find_sub_category_name	

	def new
		@post = Post.new()
		@categories = Category.where("parent_id" =>nil, "user_id" =>session[:current_user_id]).order("name ASC")
	end


	def create		
		@post = Post.new(post_params)
		@categories = Category.where("parent_id" =>nil, "user_id" =>session[:current_user_id]).order("name ASC")
		@post.user_id= session[:current_user_id]		
		if(params[:subcategory_id]!= nil)
			@post.category_id = params[:subcategory_id]
		end		
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
		@categories = Category.where("parent_id" =>nil, "user_id" =>session[:current_user_id]).order("name ASC")
		category = Category.where(:id => @post.category_id).first
		@find_category = category
		if (category.parent_id != nil)
			@find_category = Category.where(:id => category.parent_id).first		
		end		
	end

	def update
		@categories = Category.where("parent_id" =>nil, "user_id" =>session[:current_user_id]).order("name ASC")		
		@post= Post.find(params[:id])
		category = Category.where(:id => @post.category_id).first
		@find_category = category
		if (category.parent_id != nil)
			@find_category = Category.where(:id => category.parent_id).first			
		end
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
		redirect_to posts_path
	end


	def destroy
		post = Post.find(params[:id]).destroy
		flash[:notice]= "Post '#{post.title}' destroyed successfully."
		redirect_to posts_path
	end

	def show
		if (params[:id]==nil && params[:post_id])
			@post= Post.find(params[:post_id])
		else
			@post= Post.find(params[:id])
		end
		@category = Category.where(:id => @post.category_id).first
		@parent_category = Category.where(:id => @category.parent_id).first		
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

	def get_sub_category
		sub_categories = Category.where(:parent_id =>params[:id])
		result = {'res' => sub_categories, 'message' => 'Sub-categories.'}	   
	    render json: result, status: 200
	end

	private
		def post_params			
			params.require(:post).permit(:title,:body,:user_id,:deleted_at,:image,:category_id,:subcategory_id)			
		end
end
