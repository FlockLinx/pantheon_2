class AddFieldsToRewards < ActiveRecord::Migration[5.2]
  def change
    add_column :rewards, :active, :boolean, default: true
    add_column :rewards, :created_by_user_id, :integer
    add_column :rewards, :quantity_available, :integer, default: nil
    add_column :rewards, :quantity_total, :integer, default: nil
    add_column :rewards, :description, :text
  end
end
