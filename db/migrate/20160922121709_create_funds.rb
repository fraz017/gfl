class CreateFunds < ActiveRecord::Migration
  def change
    create_table :funds do |t|
      t.string :month
      t.float :total_amount
      t.float :remaining_amount

      t.timestamps null: false
    end
  end
end
