class AddDeletedToCase < ActiveRecord::Migration
  def change
    add_column :cases, :deleted, :boolean, default: false
  end
end
