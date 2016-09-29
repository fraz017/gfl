class CreateDisbursments < ActiveRecord::Migration
  def change
    create_table :disbursments do |t|
      t.float :amount
      t.text :details
      t.references :case, index: true, foreign_key: true, on_delete: :cascade

      t.timestamps null: false
    end
  end
end
