class AddCreatorIdToCase < ActiveRecord::Migration
  def change
    add_column :cases, :creator_id, :integer
  end
end
