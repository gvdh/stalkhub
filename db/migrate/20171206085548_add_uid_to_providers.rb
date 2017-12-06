class AddUidToProviders < ActiveRecord::Migration[5.1]
  def change
    add_column :providers, :uid, :string
  end
end
