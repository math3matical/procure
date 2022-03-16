class FixTagAndTagItems < ActiveRecord::Migration[7.0]
  def change
    remove_column :tag_items, :tag_taggable_id, :string
    remove_column :tag_items, :tag_taggable_type, :string
    add_column :tags, :tag_taggable_id, :integer
    add_column :tags, :tag_taggable_type, :string
    add_reference :tag_items, :tag_groups, foreign_key: true
    remove_reference :tags, :tag_groups, foreign_key: true
  end
end
