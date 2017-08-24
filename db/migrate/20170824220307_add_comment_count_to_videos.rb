class AddCommentCountToVideos < ActiveRecord::Migration[5.0]
  def change
    add_column :videos, :comments_count, :integer
  end
end
