class Case < ActiveRecord::Base
	as_enum :state, pending: 0, rejected: 1, open: 2, closed: 3
	belongs_to :user
	has_many :medium

	scope :pending, -> { where(state_cd: 0) }
	scope :rejected, -> { where(state_cd: 1) }
	scope :open, -> { where(state_cd: 2) }
	scope :closed, -> { where(state_cd: 3) }
end
