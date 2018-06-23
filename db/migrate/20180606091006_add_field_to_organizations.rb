class AddFieldToOrganizations < ActiveRecord::Migration[5.2]
  def change
    add_column :organizations, :organization_tags, :text, array: true, default: []

  end
end
