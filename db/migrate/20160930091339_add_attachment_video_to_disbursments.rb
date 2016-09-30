class AddAttachmentVideoToDisbursments < ActiveRecord::Migration
  def self.up
    change_table :disbursments do |t|
      t.attachment :video
    end
  end

  def self.down
    remove_attachment :disbursments, :video
  end
end
