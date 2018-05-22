class CreateRewards < ActiveRecord::Migration[5.2]
  def change
    create_table :rewards do |t|
      t.string :name
      t.integer :cost
      t.string :displaed_cost
      t.integer :ordanization_id

      t.timestamps
    end
  end
end
