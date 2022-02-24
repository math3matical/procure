class CreateEngineerTags < ActiveRecord::Migration[7.0]
  def change
    create_table :engineer_tags do |t|
      t.integer :engineer_taggable_id
      t.string :engineer_taggable_type

      t.timestamps
    end
  end
end
