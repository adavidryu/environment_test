class CreateAdmins < ActiveRecord::Migration[8.0]
  def change
    create_table :admins do |t|
      t.string :email, null: false
      t.string :full_name
      t.string :uid
      t.string :avatar_url

      t.timestamps
    end

    add_index :admins, :email, unique: true
    add_index :admins, :uid, unique: true
  end
end
