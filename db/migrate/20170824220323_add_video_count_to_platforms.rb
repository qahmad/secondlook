class AddVideoCountToPlatforms < ActiveRecord::Migration[5.0]
  def change
    add_column :platforms, :videos_count, :integer
  end
end
