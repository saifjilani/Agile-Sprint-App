class CreateSprintUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :sprint_users do |t|
      t.belongs_to :sprint, index: true
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
