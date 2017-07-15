class CommentsController < ApplicationController
	layout "comment"
	before_action :store_return_to
	before_action :confirm_logged_in 
	add_breadcrumb "home", :root_path
	# def index

	# end

	def create
		# byebug

		@post =Post.find(params[:post_id])

		# abort(comment_params.class.to_s)
		# @comment_params["user_id"]= session[:current_user_id]
		change_params = comment_params.clone
		change_params[:user_id]= session[:current_user_id]
		@comment = @post.comments.build(change_params)
		#abort(comment_params[:image].class.to_s)
		# abort(comment_params)
		if(comment_params[:name]=="")
			flash[:name]= "Name cannot be blank."
		end

		if(comment_params[:body]=="")
			
			if (comment_params[:image].is_a? String)
				if(comment_params[:image].tr('{}', '')=="")
				flash[:body]= "Body cannot be blank."
				flash[:image]= "Please choose one image."
				# byebug
				end	
			end		
		end



		# abort(@comment.inspect)
		# redirect_to(post_path(@post))
		if @comment.save
			flash[:notice]= "great."
			redirect_to(post_path(@post))	
		else
		
			flash[:notice]= "something wrong."

			  redirect_to post_path(@post)
			 # byebug
			 # render "posts/show"
		end	
	end

	def edit
		   # abort(params.to_json)
		 @post= Post.find(params[:post_id])
		 @comment = Comment.find(params[:id])
	end


	def update
		@post= Post.find(params[:post_id])
		@comment = Comment.find(params[:id])
		if(comment_params[:body]=="")
			
			if (comment_params[:image].is_a? String)
				if(comment_params[:image].tr('{}', '')=="")
				flash[:body]= "Body cannot be blank."
				flash[:image]= "Please choose one image."
				# byebug
				end	
			end		
		end
		if @comment.update_attributes(comment_params)
			flash[:notice]= "commant updated successfully."
			redirect_to posts_path
		else
			flash[:notice] = "something wrong."
			render 'edit'
		end 
	end


	def soft_publish
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])

		# abort()
		if(is_admin?(session[:current_user_id]))
			@comment.update_attributes(publish: false)
			flash[:notice]= "Comment '#{@comment.name}' un-publish successfully."
			redirect_to post_path(@post)
		else
			flash[:notice] = "you are not authorized to un-publish this comment."
			redirect_to post_path(@post)
		end
	end

	def soft_unpublish
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])

		# abort()
		if(is_admin?(session[:current_user_id]))
			@comment.update_attributes(publish: true)
			flash[:notice]= "Comment '#{@comment.name}' publish successfully."
			# byebug
			redirect_to post_path(@post)
		else
			flash[:notice] = "you are not authorized to publish this comment."
			redirect_to post_path(@post)
		end
	end


	

	def destroy
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])

		# abort()
		if(@post.user_id==session[:current_user_id])
			@comment.destroy

			redirect_to post_path(@post)
		else
			flash[:notice] = "you are not authorized to destroy this comment."
			redirect_to post_path(@post)
		end
	end



	def is_admin?(user)

		user = User.find(user)
		user.is_admin
	end
	helper_method :is_admin?


	private
	
		def comment_params

			@comment_params=params.require(:comment).permit(:name,:body,:user_id,:image)	
		end


end
