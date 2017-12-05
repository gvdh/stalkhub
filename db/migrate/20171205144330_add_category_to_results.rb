class AddCategoryToResults < ActiveRecord::Migration[5.1]
  def change
    add_column :results, :category, :string
  end
end
