class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :auth_provider, null: false
      t.string :uid, null: false
      t.string :name
      t.string :username, unique: true
      t.string :image_url
      t.string :url

      t.timestamps
    end

    add_index :users, [:auth_provider, :uid], unique: true
  end
end
