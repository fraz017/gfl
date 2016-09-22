module DonationsHelper
	def funds
		month = Date.today.strftime("%B")
		f = Fund.where(month: month).first
		return f.remaining_amount if f.present?
		return 0
	end
end
