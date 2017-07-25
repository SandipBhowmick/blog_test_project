class Comment < ActiveRecord::Base
	attachment :image
	belongs_to :post
	belongs_to :user
	validates :name, :presence => true
	validates :body, presence: true, unless: :image
	validates :image, presence: true, unless: :body

end
