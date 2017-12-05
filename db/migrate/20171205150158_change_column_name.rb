class ChangeColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :results, :picture_url, :attachments
  end
end
