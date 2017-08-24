class AddVideoCountToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :videos_count, :integer
  end
end
