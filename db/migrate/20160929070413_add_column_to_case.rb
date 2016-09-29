class AddColumnToCase < ActiveRecord::Migration
  def change
  	add_column :cases, :notification_date, :string
  	add_column :cases, :refered_by, :string
  	add_column :cases, :age, :string
  	add_column :cases, :gender, :string
  	add_column :cases, :contact_number, :string
  	add_column :cases, :contact_relation, :string
  	add_column :cases, :contact_name, :string
  	add_column :cases, :address, :text
  	add_column :cases, :cnic, :string
  	add_column :cases, :problem, :string
  	add_column :cases, :duration, :string
  	add_column :cases, :doctor, :string
    add_column :cases, :hospital, :string
  	add_column :cases, :doctor_contact, :string
  	add_column :cases, :verification_doc, :boolean, default: false
  	add_column :cases, :benificiary_name, :string
    add_column :cases, :benificiary_address, :text
  	add_column :cases, :benificiary_bank, :string
  	add_column :cases, :bank_address, :string
  	add_column :cases, :account_number, :string
  	add_column :cases, :iban, :string
  	add_column :cases, :swift_code, :string
  	add_column :cases, :verification_method, :text
  end
end
