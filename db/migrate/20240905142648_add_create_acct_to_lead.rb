class AddCreateAcctToLead < ActiveRecord::Migration[7.1]
  def change
    add_column :leads, :create_acct, :boolean, default: true
  end
end
