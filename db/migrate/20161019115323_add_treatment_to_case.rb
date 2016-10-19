class AddTreatmentToCase < ActiveRecord::Migration
  def change
    add_column :cases, :treatment, :string
  end
end
