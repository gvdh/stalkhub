class AddTotalLikesToResults < ActiveRecord::Migration[5.1]
  def change
    add_column :results, :total_likes, :string
  end
end
