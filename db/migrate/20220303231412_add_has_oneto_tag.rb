class AddHasOnetoTag < ActiveRecord::Migration[7.0]
  def change
    add_reference :tags, :tag_item, index: true
  end
end
