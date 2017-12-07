class AddDateToResults < ActiveRecord::Migration[5.1]
  def change
    add_column :results, :date, :string
  end
end
