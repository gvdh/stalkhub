class AddCreatedTimeToResults < ActiveRecord::Migration[5.1]
  def change
      add_column :results, :created_time, :string
  end
end
