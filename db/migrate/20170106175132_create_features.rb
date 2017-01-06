class CreateFeatures < ActiveRecord::Migration[5.0]
  def change
    create_table :features do |t|
      t.belongs_to :sprint, index: true
      t.integer :rank
      t.decimal :estimated_total_hours
      t.decimal :estimated_remaining_hours
      t.decimal :actual_worked_hours

      t.timestamps
    end
  end
end
