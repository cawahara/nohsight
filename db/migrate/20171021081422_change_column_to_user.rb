class ChangeColumnToUser < ActiveRecord::Migration[5.0]
   def up
      change_column :users, :is_admin, :boolean, default: false
   end
end
