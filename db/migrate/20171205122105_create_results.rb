class CreateResults < ActiveRecord::Migration[5.1]
  def change
    create_table :results do |t|
      t.text :caption
      t.text :message
      t.text :story
      t.string :node_id
      t.string :picture_url
      t.string :privacy
      t.string :link
      t.references :provider, foreign_key: true

      t.timestamps
    end
  end
end
