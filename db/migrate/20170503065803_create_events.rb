class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.integer :place_id
      t.string :title
      t.datetime :start_date
      t.datetime :end_date
      t.string :ticket
      t.text :information
      t.string :official_url

      t.timestamps
    end
  end
end
