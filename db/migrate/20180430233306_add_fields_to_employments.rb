class AddFieldsToEmployments < ActiveRecord::Migration[5.2]
  def change
    add_column :employments, :active_job, :boolean, default: true
  end
end
