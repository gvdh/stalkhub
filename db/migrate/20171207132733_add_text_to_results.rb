class AddTextToResults < ActiveRecord::Migration[5.1]
  def change
    add_column :results, :text, :string
  end
end
