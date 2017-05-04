class CreatePlaces < ActiveRecord::Migration[5.0]
  def change
    create_table :places do |t|
      t.string :address
      t.string :official_site_url

      t.timestamps
    end
  end
end
