class CreateProviders < ActiveRecord::Migration[5.1]
  def change
    create_table :providers do |t|
      t.string :name
      t.string :token
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
