class CreateOrganizations < ActiveRecord::Migration[5.2]
  def change
    create_table :organizations do |t|
      t.string :trading_name
      t.string :organization_tags, array: true, default: []

      t.timestamps
    end
  end
end
