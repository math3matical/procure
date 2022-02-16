class CreateNetworkTags < ActiveRecord::Migration[7.0]
  def change
    create_table :network_tags do |t|
      t.boolean :ipv4
      t.boolean :ipv6
      t.boolean :bond
      t.boolean :vlan
      t.boolean :bridge
      t.boolean :proxy
      t.boolean :firewall
      t.string :network_taggable_type
      t.integer :network_taggable_id
      t.timestamps
    end
  end
end
