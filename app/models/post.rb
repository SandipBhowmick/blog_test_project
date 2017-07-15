class Post < ActiveRecord::Base
	# validates_associated :comment
	attachment :image
	has_many :comments, dependent: :destroy
	belongs_to :user
	has_one :post_detail
	validates :title, :presence => true

	validates :body, presence: true, unless: :image
	validates :image, presence: true, unless: :body

	# validate :at_least_one_type_of_post

	# def at_least_one_type_of_post
	#   unless [body, image].any?{|val| val.present? }
	#     errors.add :post, 'To post your content need put at least one body or image !'
	#   end
	# end 

	# validate :at_least_one_type_of_post

	# def at_least_one_type_of_post
	#   unless [body, image].include?(true)
	#     errors.add :post, ('Please put something one body or Image .')
	#   end
	# end  
	
end
