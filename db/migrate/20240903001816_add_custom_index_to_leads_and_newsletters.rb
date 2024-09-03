class AddCustomIndexToLeadsAndNewsletters < ActiveRecord::Migration[7.1]
  def change
    add_index :leads, :email, name: 'leads_email_index'
    add_index :newsletters, :email, name: 'newsletters_email_index'
  end
end
