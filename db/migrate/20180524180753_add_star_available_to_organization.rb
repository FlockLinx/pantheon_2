class AddStarAvailableToOrganization < ActiveRecord::Migration[5.2]
  def change
    add_column :organizations, :stars_by_month, :integer
  end
end
