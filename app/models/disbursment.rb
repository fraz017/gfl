class Disbursment < ActiveRecord::Base
  belongs_to :case
  validates_presence_of :amount, :details

  #after_save :set_recieve_amount

  def set_recieve_amount
  	binding.pry
  end
end
