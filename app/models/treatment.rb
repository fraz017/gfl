class Treatment < ActiveRecord::Base
  belongs_to :problem
  validates_uniqueness_of :name
  scope :search_by_name, ->(query){ 
    (query ? where(["LOWER (name) LIKE ?", query.downcase + '%']): {}).select("DISTINCT (name), id, problem_id").limit(5)
  }
end
