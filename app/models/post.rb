class Post < ActiveRecord::Base
	attr_accessor :subcategory_id
	# validates_associated :comment
	attachment :image
	has_many :comments, dependent: :destroy
	belongs_to :user
	belongs_to :category
	belongs_to :subcategory
	# has_one :post_detail
	validates :title, presence: true

	validates :body, presence: true, unless: :image
	validates :image, presence: true, unless: :body
	validates :category_id, presence: true

	validate  :presence_of_subcategory
	


	def presence_of_subcategory

		if(Category.where(:parent_id => self.category_id).first && self.subcategory_id == "" )
			
			errors.add(:subcategory_id, "Please select subcategory")
		end	

	    if (self.subcategory_id != nil && self.subcategory_id != "")
	      
	      self.category_id =self.subcategory_id
	    end

    end
  

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
