class Donation < ActiveRecord::Base
	validates_presence_of :amount
	before_create :set_month
	after_save :set_funds
	after_destroy :set_funds
	def set_month
		self.month = Date.today.strftime("%B %Y")
	end

	def set_funds
		f = Fund.find_or_create_by(id: 1)
		f.total_amount = self.amount.to_f
		f.remaining_amount = f.remaining_amount.to_f + self.amount.to_f
		f.save
	end
end
