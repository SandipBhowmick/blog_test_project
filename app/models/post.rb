class Post < ActiveRecord::Base
	attr_accessor :subcategory_id	
	attachment :image
	has_many :comments, dependent: :destroy
	belongs_to :user
	belongs_to :category
	belongs_to :subcategory	
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
end
