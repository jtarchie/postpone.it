class CreateVideos < ActiveRecord::Migration
  def self.up
    create_table :videos do |t|
      t.belongs_to :user
      t.text :title
      t.text :description
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :videos
  end
end
