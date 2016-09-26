class Donation < ActiveRecord::Base
	validates_presence_of :amount
	after_save :set_funds

	def set_funds
		month = Date.today.strftime("%B %Y")
		f = Fund.find_or_create_by(month: month)
		f.total_amount = f.total_amount.to_f + self.amount.to_f
		f.remaining_amount = f.remaining_amount.to_f + self.amount.to_f
		f.save
	end
end
