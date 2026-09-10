class AddAuthTokenToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :auth_token_digest, :string
    add_column :users, :auth_token_created_at, :datetime
  end
end
