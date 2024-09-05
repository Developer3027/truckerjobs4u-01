class AddPasselToLead < ActiveRecord::Migration[7.1]
  def change
    add_column :leads, :passel, :string
  end
end
