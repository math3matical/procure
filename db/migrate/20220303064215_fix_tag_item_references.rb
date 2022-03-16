class FixTagItemReferences < ActiveRecord::Migration[7.0]
  def change
    remove_reference :tag_items, :tag_groups, foreign_key: true
    add_reference :tag_items, :tag_group, foreign_key: true
  end
end
