class RenameFieldOrganizationOnSameTables < ActiveRecord::Migration[5.2]
  def change
    rename_column :rewards, :ordanization_id, :organization_id
    rename_column :posts, :ordanization_id, :organization_id
  end
end
