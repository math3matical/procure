class FixColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :comments, :article_id, :commentable_id
  end
end
