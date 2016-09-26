class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  as_enum :role, admin: 0, manager: 1

  has_many :cases
  def self.is_admin?
  	return true if role == :admin
  	return false if role == :manager
  end

  def self.is_manager?
  	return false if role == :admin
  	return true if role == :manager
  end       
end
