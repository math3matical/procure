class FixColumnName3 < ActiveRecord::Migration[7.0]
  def change
    rename_column :comments, :comentable_type, :commentable_type
    remove_foreign_key :comments, :articles
  end
end
