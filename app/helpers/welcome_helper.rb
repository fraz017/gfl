module WelcomeHelper
	def funds
		f = Fund.find(1)
		return f.remaining_amount if f.present?
		return 0
	end

	def afunds
		f = Fund.find(1)
		return f.total_amount if f.present?
		return 0
	end

	def managers
		User.where(role_cd: 1).count
	end

	def required
		Case.where(state_cd: 2).sum(:remaining)
	end
	
	def pending
		Case.where(state_cd: 0).count
	end

	def open
		Case.where(state_cd: 2).count
	end

	def rejected
		Case.where(state_cd: 1).count
	end

	def closed
		Case.where(state_cd: 3).count
	end
end
