class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.integer :event_id
      t.string :grade
      t.integer :price

      t.timestamps
    end
  end
end
