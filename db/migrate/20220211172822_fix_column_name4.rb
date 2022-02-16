class FixColumnName4 < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :url, :text
  end
end
