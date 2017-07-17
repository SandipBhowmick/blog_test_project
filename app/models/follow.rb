class Follow < ActiveRecord::Base
	# validate  :follow_uniqueness_of_count, :on => :create


	belongs_to :user
  

  # def follow_uniqueness_of_count
  # 	database_data=self.class.find_by(:follower_id => follower_id)
  
  # 	# abort("name_uniqueness_validate")
  #   if (user_id == database_data.user_id)
  #     errors.add(:name, "you have already follow the user")
  #   end
  # end
end
