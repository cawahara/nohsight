class CreatePointRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :point_records do |t|
      t.integer   :user_id
      t.integer   :event_id
      t.integer   :point
      t.text      :action

      t.timestamps
    end
  end
end
