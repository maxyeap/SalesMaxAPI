class CreateDeals < ActiveRecord::Migration[7.0]
  def change
    create_table :deals do |t|
      t.string :title, null: false
      t.decimal :amount, null: false
      t.string :currency, null: false
      t.string :status, null: false
      t.string :stage, null: false
      t.date :close_date
      t.integer :probability
      t.references :lead, foreign_key: true
      t.string :priority

      t.timestamps
    end
  end
end
