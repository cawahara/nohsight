class CreateEventPrograms < ActiveRecord::Migration[5.0]
  def change
    create_table :event_programs do |t|
      t.integer :event_id
      t.integer :program_id
      t.string  :genre

      t.timestamps
    end
  end
end
