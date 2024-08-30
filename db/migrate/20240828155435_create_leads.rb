class CreateLeads < ActiveRecord::Migration[7.1]
  def change
    create_table :leads do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :location
      t.text :note
      t.boolean :pp_check, default: true

      t.timestamps
    end
  end
end
