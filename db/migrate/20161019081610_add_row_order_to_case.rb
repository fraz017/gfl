class AddRowOrderToCase < ActiveRecord::Migration
  def change
    add_column :cases, :row_order, :integer
  end
end
