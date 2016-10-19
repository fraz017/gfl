class Problem < ActiveRecord::Base
	has_many :treatments
	
	validates_uniqueness_of :name

	scope :search_by_name, ->(query){ 
    (query ? where(["LOWER (name) LIKE ?", query.downcase + '%']): {}).select("DISTINCT (name), id").limit(5)
  }
end
