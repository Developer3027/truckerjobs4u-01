class RenameEmailColumnsInLeadsAndNewsletters < ActiveRecord::Migration[7.1]
  def change
    rename_column :leads, :email, :lead_email
    rename_column :newsletters, :email, :newsletter_email
  end
end
