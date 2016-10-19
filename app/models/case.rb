class Case < ActiveRecord::Base
	include RankedModel
  ranks :row_order

  has_many :requests
  has_many :attachments
	as_enum :state, pending: 0, rejected: 1, open: 2, closed: 3
	belongs_to :user, :class_name => 'User'
	belongs_to :creator, :class_name => 'User'
	has_many :medium
	has_many :disbursments

	scope :pending, -> { where(state_cd: 0, deleted: false) }
	scope :rejected, -> { where(state_cd: 1, deleted: false) }
	scope :open, -> { where(state_cd: 2, deleted: false) }
	scope :closed, -> { where(state_cd: 3, deleted: false) }

	validates_presence_of :name, :budget, :notification_date, :refered_by, :age, :gender, :contact_number, :address, :problem, :treatment, :duration, :doctor, :hospital, :doctor_contact

	accepts_nested_attributes_for :attachments, allow_destroy: true
	
	after_save :set_remaining_funds

	before_save :set_creator, :set_problem, :set_remaining

	def set_problem
		p = Problem.find_or_create_by(name: self.problem)
		t = Treatment.find_or_create_by(name: self.treatment, problem_id: p.id)
	end

	def set_creator
		if self.user_id.present?
			self.creator_id = self.user_id
		end
	end

	def set_remaining
		self.remaining = self.budget.to_f - self.recieved.to_f
	end

	def set_remaining_funds
		f = Fund.find_or_create_by(id: 1)
		f.remaining_amount = f.total_amount - Case.all.sum(:recieved)
		f.save
	end
end
