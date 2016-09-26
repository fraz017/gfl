class AddAttachmentFileToMedia < ActiveRecord::Migration
  def self.up
    change_table :media do |t|
      t.attachment :file
    end

    change_column :cases, :state_cd, :integer, :default => 0
  end

  def self.down
    remove_attachment :media, :file
  end
end
