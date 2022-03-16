class CreateTagItems < ActiveRecord::Migration[7.0]
  def change
    create_table :tag_items do |t|
      t.string :name
      t.string :tag_taggable_type
      t.string :tag_taggable_id
      t.timestamps
    end
  end
end
