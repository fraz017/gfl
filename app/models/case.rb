class Case < ActiveRecord::Base
	as_enum :state, pending: 0, rejected: 1, open: 2, closed: 3
	belongs_to :user
	has_many :medium
	has_many :disbursments

	scope :pending, -> { where(state_cd: 0) }
	scope :rejected, -> { where(state_cd: 1) }
	scope :open, -> { where(state_cd: 2) }
	scope :closed, -> { where(state_cd: 3) }

	validates_presence_of :name, :budget, :notification_date, :refered_by, :age, :gender, :contact_number, :address, :problem, :duration, :doctor, :hospital, :doctor_contact, :verification_method

	#after_save :set_remaining_funds

	def set_remaining_funds
		month = Date.today.strftime("%B %Y")
		f = Fund.find_or_create_by(month: month)
		f.remaining_amount = f.remaining_amount.to_f - self.recieved_amount.to_f
		f.save
	end
end
