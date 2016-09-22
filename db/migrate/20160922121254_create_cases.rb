class CreateCases < ActiveRecord::Migration
  def change
    create_table :cases do |t|
      t.float :budget
      t.string :name
      t.integer :state_cd
      t.references :user
      t.float :recieved

      t.timestamps null: false
    end
  end
end
