class AddAvatarToResults < ActiveRecord::Migration[5.1]
  def change
    add_column :results, :avatar, :string
  end
end
