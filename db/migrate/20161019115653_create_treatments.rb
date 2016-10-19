class CreateTreatments < ActiveRecord::Migration
  def change
    create_table :treatments do |t|
      t.string :name
      t.references :problem, index: true, foreign_key: true, on_delete: :cascade

      t.timestamps null: false
    end
  end
end
