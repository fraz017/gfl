class AddAddress2AndCityToCase < ActiveRecord::Migration
  def change
    add_column :cases, :address2, :string
    add_column :cases, :city, :string
  end
end
