class AddDeleteAccountDateToLead < ActiveRecord::Migration[7.1]
  def change
    add_column :leads, :delete_account_date, :datetime
  end
end
