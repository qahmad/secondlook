class AddTagCountToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :tags_count, :integer
  end
end
