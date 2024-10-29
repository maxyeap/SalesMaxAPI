class CreateActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :activities do |t|
      t.string :title, null: false
      t.text :description
      t.string :activity_type, null: false
      t.datetime :start_date, null: false
      t.datetime :end_date
      t.integer :duration
      t.string :status, null: false
      t.references :deal, null: false, foreign_key: true

      t.timestamps
    end
  end
end
