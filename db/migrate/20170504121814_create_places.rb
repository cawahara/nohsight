class CreatePlaces < ActiveRecord::Migration[5.0]
  def change
    create_table :places do |t|
      t.string :title
      t.string :address
      t.string :official_url

      t.timestamps
    end
  end
end
