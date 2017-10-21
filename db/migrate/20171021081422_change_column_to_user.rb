class ChangeColumnToUser < ActiveRecord::Migration[5.0]
   def up
      change_column :events, :category, :string, default: 'その他'
   end
end
