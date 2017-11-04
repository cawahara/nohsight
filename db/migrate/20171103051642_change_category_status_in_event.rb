class ChangeCategoryStatusInEvent < ActiveRecord::Migration[5.0]
   def change
      remove_column :events, :category, :string
      add_column :events, :category, :integer, default: 0
   end
end
