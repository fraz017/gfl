class AddRemainingToCase < ActiveRecord::Migration
  def change
    add_column :cases, :remaining, :float
  end
end
