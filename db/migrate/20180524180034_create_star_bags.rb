class CreateStarBags < ActiveRecord::Migration[5.2]
  def change
    create_table :star_bags do |t|
      t.integer :user_id
      t.integer :organization_id
      t.integer :star_amount, default: 0
      t.integer :available_stars

      t.timestamps
    end
  end
end
