class AddDescriptionToResults < ActiveRecord::Migration[5.1]
  def change
    add_column :results, :description, :text
  end
end
