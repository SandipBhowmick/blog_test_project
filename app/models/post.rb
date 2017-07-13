class Post < ActiveRecord::Base
	# validates_associated :comment

	has_many :comments, dependent: :destroy
	belongs_to :user

	validates :title,:body, :presence => true
end
