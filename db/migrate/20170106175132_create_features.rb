class CreateFeatures < ActiveRecord::Migration[5.0]
  def change
    create_table :features do |t|
      t.belongs_to :sprint, index: true
      t.integer :rank, null: false
      t.decimal :estimated_total_hours, null: false
      t.decimal :estimated_remaining_hours, null: false
      t.decimal :actual_worked_hours, null: false

      t.timestamps
    end
  end
end
