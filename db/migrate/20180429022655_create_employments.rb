class CreateEmployments < ActiveRecord::Migration[5.2]
  def change
    create_table :employments do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :organization, foreign_key: true
      
      t.timestamps
    end
  end
end
