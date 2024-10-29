class ChangeLeadIdToNotNullInDeals < ActiveRecord::Migration[7.0]
  def change
    change_column_null :deals, :lead_id, false
  end
end
