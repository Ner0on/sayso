class Business < ActiveRecord::Base
	has_many :reviews

	validates :business_name, presence: true
	validates :location, presence: true

end
