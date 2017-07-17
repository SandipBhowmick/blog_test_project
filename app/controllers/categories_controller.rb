class CategoriesController < ApplicationController
	layout "category"
	before_action :store_return_to
	before_action :confirm_logged_in
	
	

	def new
		@category = Category.new()
		# @category = (flash[:category]) ? flash[:category] : Category.new
		@perent_categorys = Category.where("parent_id" =>nil, "user_id" =>session[:current_user_id])
		# abort(session[:current_user_id].to_json)
		# @perent_categorys = Category.where("parent_id = ?  AND user_id = ? ",nil,session[:current_user_id])
	end

	def create
		# @perent_categorys = Category.where("parent_id" =>nil, "user_id" =>session[:current_user_id])
		# abort()
		@category=Category.new(category_params)
		@perent_categorys = Category.where("parent_id" =>nil, "user_id" =>session[:current_user_id])
		@category.user_id = session[:current_user_id]
		# abcd
		if @category.save
			flash[:notice]= "Category created successfully."
			redirect_to(:controller =>'access', :action => 'index')
		else
			flash[:category] = @category
			render 'new'
		end 
		 # @category = Category.new()
	end

	def edit
		@category=Category.find(params[:id])		
		@perent_categorys = Category.where("parent_id" =>nil, "user_id" =>session[:current_user_id]).where.not(id:@category.id)

	end

	def update
		@category=Category.find(params[:id])
		@c_name = @category.name		
		@perent_categorys = Category.where("parent_id" =>nil, "user_id" =>session[:current_user_id]).where.not(id:@category.id)
		if @category.update_attributes(category_params)
			flash[:notice]= "Category updated successfully."
			redirect_to(:controller =>'access', :action => 'index')
		else
			flash[:category] = @category
			render 'edit'
		end 

	end

	def delete
    	@category=Category.find(params[:id])
  	end


	def destroy
		category = Category.find(params[:id]).destroy
		flash[:notice]= "User '#{category.name}' destroyed successfully."
		redirect_to(:action =>'index', :page_id => category.id)
		#redirect_to(:action => 'index', :page_id => @page.id)
	end

	def show
		@category = Category.find(params[:id])
		@subcategories = Category.where(parent_id: @category.id)
	end

	def index
		c_user = User.find_by_id(session[:current_user_id])
		@categories = c_user.categories  
	end



	private

		def category_params
			params.require(:category).permit(:parent_id, :user_id, :name)
		end 

end
