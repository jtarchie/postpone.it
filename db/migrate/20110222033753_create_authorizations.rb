class CreateAuthorizations < ActiveRecord::Migration
  def self.up
    create_table :authorizations do |t|
      t.belongs_to :user
      t.string :provider
      t.string :uid

      t.timestamps
    end

    add_index :authorizations, [:user_id, :provider]
  end

  def self.down
    drop_table :authorizations
  end
end
