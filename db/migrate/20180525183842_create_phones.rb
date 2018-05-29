class CreatePhones < ActiveRecord::Migration[5.2]
  def change
    create_table :phones do |t|
      t.string   "number"
      t.string   "phoneable_type"
      t.integer  "phoneable_id"

      t.timestamps
    end
  end
end
