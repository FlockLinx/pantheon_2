class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :subject
      t.string :origin
      t.text :message
      t.integer :created_by_user_id

      t.timestamps
    end
  end
end
