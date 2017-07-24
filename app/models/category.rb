class Category < ActiveRecord::Base

  has_many :subcategories, :class_name => "Category", :foreign_key => "parent_id", :dependent => :destroy
	validates :name,:user_id, :presence => true

	validate  :name_uniqueness_validate, :on => :create
	belongs_to :user
  has_many  :posts
	validate  :name_uniqueness_validate_two, :on => :update



  

  def name_uniqueness_validate
  	# abort("name_uniqueness_validate")
    if self.class.exists?( :user_id => user_id,:name => name)
      errors.add(:name, "already exists")
    end
  end



  def name_uniqueness_validate_two
  	# abort((self.class.exists?( :user_id => user_id, :parent_id =>parent_id, :name => name)).to_s)
   	 database_data=self.class.find_by(id: id)
    # p database_data.class
    # p self.class

    # database_data.compare(self)

    # byebug

    if !(self.name == database_data.name && self.user_id == database_data.user_id && self.parent_id == database_data.parent_id)
  	
      if self.class.exists?( :user_id => user_id, :parent_id =>parent_id, :name => name)
          
          errors.add(:name, "already exists")
        end
  	end
    end
end
