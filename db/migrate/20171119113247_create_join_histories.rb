class CreateJoinHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :join_histories do |t|
      t.integer :user_id
      t.integer :event_id
      t.integer :status

      t.timestamps
    end
  end
end
