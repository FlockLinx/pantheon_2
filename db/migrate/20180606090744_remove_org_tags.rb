class RemoveOrgTags < ActiveRecord::Migration[5.2]
  def change
    remove_column :organizations, :organization_tags
  end
end
