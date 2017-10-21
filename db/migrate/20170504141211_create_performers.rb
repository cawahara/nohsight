class CreatePerformers < ActiveRecord::Migration[5.0]
  def change
    create_table :performers do |t|
      t.string    :full_name
      t.string    :last_name
      t.string    :first_name
      t.integer   :style_id

      t.timestamps
    end
  end
end
