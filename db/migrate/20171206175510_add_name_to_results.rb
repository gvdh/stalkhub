class AddNameToResults < ActiveRecord::Migration[5.1]
  def change
    add_column :results, :name, :string
  end
end
