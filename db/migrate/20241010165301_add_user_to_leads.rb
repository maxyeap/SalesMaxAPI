class AddUserToLeads < ActiveRecord::Migration[7.0]
  def change
    add_reference :leads, :user, null: false, foreign_key: true
  end
end
