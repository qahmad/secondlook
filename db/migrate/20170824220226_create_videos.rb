class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :caption
      t.string :videolink
      t.integer :starttime
      t.integer :user_id
      t.integer :platform_id

      t.timestamps

    end
  end
end
