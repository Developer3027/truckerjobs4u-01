class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state
      t.string :zip
      t.string :country
      t.boolean :current
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
