class CreatePrograms < ActiveRecord::Migration[5.0]
  def change
    create_table :programs do |t|
      t.string :title
      t.string :category
      t.boolean :shimai
      t.integer :duration

      t.timestamps
    end
  end
end
