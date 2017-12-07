class AddFanCountToResults < ActiveRecord::Migration[5.1]
  def change
    add_column :results, :fan_count, :string
  end
end
