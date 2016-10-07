class AddCommentToDonation < ActiveRecord::Migration
  def change
    add_column :donations, :comment, :text
  end
end
