class AddSecretToAuthorizations < ActiveRecord::Migration
  def self.up
    add_column :authorizations, :secret, :string
  end

  def self.down
    remove_column :authorizations, :secret
  end
end
