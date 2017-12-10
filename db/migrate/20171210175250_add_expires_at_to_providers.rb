class AddExpiresAtToProviders < ActiveRecord::Migration[5.1]
  def change
    add_column :providers, :expires_at, :integer
  end
end
