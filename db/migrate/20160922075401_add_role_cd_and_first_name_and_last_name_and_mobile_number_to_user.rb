class AddRoleCdAndFirstNameAndLastNameAndMobileNumberToUser < ActiveRecord::Migration
  def change
    add_column :users, :role_cd, :integer
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :mobile_number, :string
  end
end
