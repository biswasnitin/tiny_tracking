class AddColumnToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :password_hash, :string
    add_column :users, :password_salt, :string
    add_column :users, :auth_token, :string
  end
end
