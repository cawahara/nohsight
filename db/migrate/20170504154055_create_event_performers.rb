class CreateEventPerformers < ActiveRecord::Migration[5.0]
  def change
    create_table :event_performers do |t|
      t.integer :event_program_id
      t.integer :performer_id

      t.timestamps
    end
  end
end
