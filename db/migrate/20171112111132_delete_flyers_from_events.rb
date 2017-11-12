class DeleteFlyersFromEvents < ActiveRecord::Migration[5.0]
  def change
     remove_column :events, :flyers
  end
end
