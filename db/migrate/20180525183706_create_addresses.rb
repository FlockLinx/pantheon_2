class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.integer  "addressable_id"
      t.integer  "state_id"
      t.string   "addressable_type"
      t.string   "street"
      t.string   "complement"
      t.string   "number"
      t.string   "zipcode"
      t.datetime "created_at",                       null: false
      t.datetime "updated_at",                       null: false
      t.string   "city"
      t.boolean  "main_address",     default: false
      t.string   "neighborhood"

      t.timestamps
    end
  end
end
