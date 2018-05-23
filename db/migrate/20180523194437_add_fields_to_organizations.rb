class AddFieldsToOrganizations < ActiveRecord::Migration[5.2]
  def change
    add_column :organizations, :created_by_user_id, :integer
    add_column :organizations, :owner_id, :integer
  end
end
