module DonationsHelper
	def funds
		f = Fund.find(1)
		return f.remaining_amount if f.present?
		return 0
	end
end
