class AddPictureToResults < ActiveRecord::Migration[5.1]
  def change
    add_column :results, :picture, :string
  end
end
