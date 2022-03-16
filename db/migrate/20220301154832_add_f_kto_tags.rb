class AddFKtoTags < ActiveRecord::Migration[7.0]
  def change
    add_reference :tags, :tag_groups, foreign_key: true
  end
end
