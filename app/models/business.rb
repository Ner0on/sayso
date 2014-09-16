class Business < ActiveRecord::Base
	has_many :reviews

	validates :business_name, presence: true
	validates :location, presence: true
	
	def self.search(query)
	  where("business_name LIKE ?", "%#{query.downcase}%") 
	end
end
