class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.references :case, foreign_key: true, on_delete: :cascade
      t.text :content

      t.timestamps null: false
    end
  end
end
