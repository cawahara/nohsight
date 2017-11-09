class AddFlyersToEvents < ActiveRecord::Migration[5.0]
  def change
     add_column :events, :flyers, :json, array: true, default: []
  end
end
