class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string    :name
      t.string    :email
      t.text      :information
      t.string    :password_digest
      t.boolean   :is_admin

      t.timestamps
    end
  end
end
