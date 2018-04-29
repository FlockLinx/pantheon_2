class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :donator_id
      t.integer :beneficiary_id
      t.string :cause
      t.string :star_amount
      t.integer :amount
      t.integer :ordanization_id
      t.string  :tags, default: ''

      t.timestamps
    end
  end
end
