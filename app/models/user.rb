class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  as_enum :role, admin: 0, manager: 1, doctor: 2

  validates_presence_of :first_name, :last_name, :email

  has_and_belongs_to_many :cases

  has_many :disbursments

  def self.is_admin?
  	return true if role == :admin
  	return false if role == :doctor
    return false if role == :manager
  end

  def self.is_manager?
  	return false if role == :admin
  	return false if role == :doctor
    return true if role == :manager
  end

  def self.is_doctor?
    return false if role == :admin
    return false if role == :manager
    return true if role == :doctor
  end

  def name_with_role
    first_name << " " << last_name << " (" << role.to_s.titleize << ")"
  end       
end
