class AddTagGroupstoTag < ActiveRecord::Migration[7.0]
  def change
    add_reference :tags, :tag_group, index: true
  end
end
