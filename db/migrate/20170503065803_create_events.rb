class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.integer   :place_id
      t.string    :title
      t.datetime  :open_date
      t.datetime  :start_date
      t.text      :information
      t.string    :official_url
      t.string    :category
      t.integer   :publishing_status
      t.integer   :original_event_id

      t.timestamps
    end
  end
end
