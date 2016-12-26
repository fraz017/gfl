class CaseUser < ActiveRecord::Migration
  def change
  	create_table :cases_users, id: false do |t|
      t.belongs_to :user
      t.belongs_to :case

      t.timestamps null: false
    end
  end
end
