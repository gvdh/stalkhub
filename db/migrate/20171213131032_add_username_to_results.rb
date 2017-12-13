class AddUsernameToResults < ActiveRecord::Migration[5.1]
  def change
    add_column :results, :username, :string
  end
end
