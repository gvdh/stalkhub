class RemoveTypeFromResults < ActiveRecord::Migration[5.1]
  def change
    remove_column :results, :type
  end
end
