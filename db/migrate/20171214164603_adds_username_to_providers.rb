class AddsUsernameToProviders < ActiveRecord::Migration[5.1]
  def change
    add_column :providers, :username, :string
  end
end
