class AddPasswordResetToUsers < ActiveRecord::Migration[5.0]
  def change
     add_column :users, :password_reset_digest, :string
  end
end
