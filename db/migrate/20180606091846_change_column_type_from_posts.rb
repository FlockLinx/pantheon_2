class ChangeColumnTypeFromPosts < ActiveRecord::Migration[5.2]
  def up
    change_column :posts, :tags, :text, array: true, default: []
  end

  def down
    change_column :posts, :tags, :string, array: true, default: []
  end
end
