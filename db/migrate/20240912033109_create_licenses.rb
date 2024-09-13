class CreateLicenses < ActiveRecord::Migration[7.1]
  def change
    create_table :licenses do |t|
      t.date :dob
      t.string :lic_class
      t.string :lic_exp
      t.text :lic_endorsements, array: true, default: []
      t.boolean :military
      t.boolean :veteran
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
