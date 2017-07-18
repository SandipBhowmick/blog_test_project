class User < ActiveRecord::Base
	
	
	attachment :profile_image
	validates :first_name,:last_name,:address, :presence => true
	validates :profile_image, presence: { message: "selection is required" }
	validates :gender, presence: { message: "selection is required" }
	validates :country_id, presence: { message: "selection is required" }
	validates :state_id, presence: { message: "selection is required" } 
	validate  :interest_validate, :on => [:create, :update]
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :email, presence: true, 
                format: { with: VALID_EMAIL_REGEX }, 
                uniqueness: { case_sensitive: false }
	
    validates :password,  length: { in: 6..16 } ,allow_blank: false
    validates :password_confirmation, 
            :presence=>true, :if => :password_digest_changed?          
    has_secure_password
    # validates_confirmation_of :password

	
	
	# validates :email, format: { with: VALID_EMAIL_REGEX }
	# validates_length_of :password, :minimum => 6, :maximum => 16
	
	# validates_uniqueness_of :email
	has_many :follows
	belongs_to :country
	has_many :categories
	belongs_to :state
	has_many :posts
	has_many :comment , :through => :post

	GET_INTEREST = {'Acting' => 1, 'Cooking' => 2, 'Dance' => 3, 'Fashion' => 4, 'Pet' => 5,  'Puzzles' => 6}
	
	

	def interest_validate
		
		 interest.delete("0")
		 # abort(interest.class.to_s)
		# abort(interest.class.to_s)
		# abort(interest.any?.to_s)
		if interest.length==0
			# abort(interest.to_s)
			errors.add(:interest, "field not selected")
		end
	end


end
