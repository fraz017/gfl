class Request < ActiveRecord::Base
  belongs_to :case
  validates_presence_of :content
end
