class ProvisionTagAddition < ActiveRecord::Migration[7.0]
  def change
    add_column :provision_tags, :bootdisk, :boolean
    add_column :provision_tags, :ipxe, :boolean
  end
end
