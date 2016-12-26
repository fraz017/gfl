class AddUserIdToDisbursment < ActiveRecord::Migration
  def change
    add_column :disbursments, :user_id, :integer
  end
end
