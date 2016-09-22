class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.float :amount
      t.string :name
      t.string :city
      t.string :state
      t.string :country
      t.string :contact_number
      t.string :email

      t.timestamps null: false
    end
  end
end
