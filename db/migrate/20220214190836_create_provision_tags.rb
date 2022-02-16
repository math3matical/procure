class CreateProvisionTags < ActiveRecord::Migration[7.0]
  def change
    create_table :provision_tags do |t|
      t.float :version
      t.integer :provision_taggable_id
      t.string :provision_taggable_type
      t.boolean :contentview
      t.boolean :capsule
      t.boolean :http
      t.boolean :ui
      t.boolean :pxe
      t.boolean :bootstrap
      t.boolean :kickstart
      t.boolean :discover
      t.boolean :image
      t.boolean :compute
      t.text :notes

      t.timestamps
    end
  end
end
