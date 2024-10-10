class CreateLeads < ActiveRecord::Migration[7.0]
  def change
    create_table :leads do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :email
      t.string :time_zone
      t.string :city
      t.string :country

      t.timestamps
    end
  end
end
